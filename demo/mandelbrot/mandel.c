// SDL2 Mandelbrot Demo by aurelien.esnard@u-bordeaux.fr
// https://rosettacode.org/wiki/Mandelbrot_set

#include <SDL.h>
#include <SDL_image.h>  // required to load transparent texture from PNG
#include <SDL_ttf.h>    // required to use TTF fonts

#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define APP_NAME "Mandelbrot"
#define DELAY 100
#define SCREEN_DIM 500

#define DIM 500
#define XMIN -2.0
#define XMAX 1.0
#define YMIN -1.0
#define YMAX 1.0
#define MAXITER 1024

// Returns duration in ms
#define TIME_DIFF(t1, t2) \
  (((t2.tv_sec - t1.tv_sec) * 1000.0) + ((t2.tv_usec - t1.tv_usec) / 1000.0))

#define ERROR(STR, ...)                  \
  do {                                   \
    fprintf(stderr, STR, ##__VA_ARGS__); \
    exit(EXIT_FAILURE);                  \
  } while (0)

struct Env_t {
  uint32_t data[DIM][DIM];
  SDL_Texture* texture;
};

typedef struct Env_t Env;

/* **************************************************************** */

uint32_t mandelbrot(float xMin, float xMax, float yMin, float yMax, int xPixels,
                    int yPixels, int maxIter, int i, int j) {
  float dx = (xMax - xMin) / (float)xPixels;
  float dy = (yMax - yMin) / (float)yPixels;
  float xc = xMin + dx * j;
  float yc = xMax - dy * i;
  float x = 0.0, y = 0.0; /* Z = X+I*Y */
  uint32_t iter;
  for (iter = 0; iter < maxIter; iter++) {
    float x2 = x * x;
    float y2 = y * y;
    /* Stop iterations when |Z| > 2 */
    if (x2 + y2 > 4.0) break;
    /* Z = Z^2 + C */
    x = x2 - y2 + xc;
    y = (2.0 * x * y) + yc;
  }
  return iter;
}

/* **************************************************************** */

/* SDL interprets each pixel as a 32-bit number, so our masks must depend
   on the endianness (byte order) of the machine */

uint32_t rgb(unsigned char r, unsigned char g, unsigned char b) {
  unsigned char a = 255; /* alpha */
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
  uint32_t color = (r << 24) | (g << 16) | (b << 8) | alpha /* big endian */;
#else
  uint32_t color = (a << 24) | (b << 16) | (g << 8) | r /* little endian */;
#endif
  return color;
}

/* **************************************************************** */

uint32_t iter2color(unsigned iter, unsigned maxiter) {
  assert(iter > 0);

  float scale = 3.0 * log(iter) / log(maxiter);  // scale in range [0,3]
  assert(scale >= 0.0f && scale <= 3.0f);

  int r, g, b;

  if (scale < 1.0f)
    r = 255 * scale, g = 0, b = 0; /* scale red channel */
  else if (scale < 2.0f)
    r = 255, g = 255 * (scale - 1.0), b = 0; /* scale green channel */
  else if (scale < 3.0f)
    r = 255, g = 255, b = 255 * (scale - 2.0f); /* scale blue channel */
  else
    r = 0, g = 0, b = 255;  // blue

  assert(r >= 0 && r <= 255);
  assert(g >= 0 && g <= 255);
  assert(b >= 0 && b <= 255);
  return rgb(r, g, b);
}

/* **************************************************************** */

Env* init(SDL_Window* win, SDL_Renderer* ren, int argc, char* argv[]) {
  Env* env = malloc(sizeof(struct Env_t));

  uint32_t maxiter = 0;
  struct timeval t1, t2;
  gettimeofday(&t1, NULL);
  for (int i = 0; i < DIM; i++)   /* row */
    for (int j = 0; j < DIM; j++) /* col */
    {
      int iter = mandelbrot(XMIN, XMAX, YMIN, YMAX, DIM, DIM, MAXITER, i, j);
      env->data[i][j] = iter;
      if (iter > maxiter) maxiter = iter;
    }

  for (int i = 0; i < DIM; i++)   /* row */
    for (int j = 0; j < DIM; j++) /* col */
    {
      uint32_t iter = env->data[i][j];
      uint32_t color = iter2color(iter, maxiter);
      env->data[i][j] = color;
    }
  gettimeofday(&t2, NULL);

  /* Create a 32-bit surface with the bytes of each pixel in R,G,B,A order,
     as expected by OpenGL for textures */
  SDL_Surface* surface = SDL_CreateRGBSurfaceWithFormatFrom(
      env->data, DIM, DIM, 32, 4 * DIM, SDL_PIXELFORMAT_RGBA32);
  env->texture = SDL_CreateTextureFromSurface(ren, surface);
  SDL_FreeSurface(surface);

  float timecomp = TIME_DIFF(t1, t2);
  printf("=> mandelbrot set of dim %dx%d computed in %.2f ms (maxiter=%d)\n",
         DIM, DIM, timecomp, maxiter);

  return env;
}

/* **************************************************************** */

void render(SDL_Window* win, SDL_Renderer* ren, Env* env) {
  SDL_SetRenderDrawColor(ren, 0x00, 0x00, 0xFF, 0xFF); /* blue */
  SDL_RenderClear(ren);                                /* set bg */
  SDL_RenderCopy(ren, env->texture, NULL, NULL);       /* stretch it */
}

/* **************************************************************** */

bool process(SDL_Window* win, SDL_Renderer* ren, Env* env, SDL_Event* e) {
  if (e->type == SDL_QUIT) {
    return true;
  } else if (e->type == SDL_KEYDOWN) {
    switch (e->key.keysym.sym) {
      case SDLK_ESCAPE:
        return true;
        break;
    }
  }
  return false;
}

/* **************************************************************** */

void clean(SDL_Window* win, SDL_Renderer* ren, Env* env) {
  SDL_DestroyTexture(env->texture);
  free(env);
}

/* **************************************************************** */

int main(int argc, char* argv[]) {
  /* initialize SDL2 and some extensions */
  if (SDL_Init(SDL_INIT_VIDEO) != 0)
    ERROR("Error: SDL_Init VIDEO (%s)", SDL_GetError());
  if (IMG_Init(IMG_INIT_PNG & IMG_INIT_PNG) != IMG_INIT_PNG)
    ERROR("Error: IMG_Init PNG (%s)", SDL_GetError());
  if (TTF_Init() != 0) ERROR("Error: TTF_Init (%s)", SDL_GetError());

  /* create window and renderer */
  SDL_Window* win = SDL_CreateWindow(
      APP_NAME, SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SCREEN_DIM,
      SCREEN_DIM, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
  if (!win) ERROR("Error: SDL_CreateWindow (%s)", SDL_GetError());
  SDL_Renderer* ren = SDL_CreateRenderer(
      win, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
  if (!ren) ERROR("Error: SDL_CreateRenderer (%s)", SDL_GetError());

  /* initialize your environment */
  Env* env = init(win, ren, argc, argv);

  /* main render loop */
  SDL_Event e;
  bool quit = false;
  while (!quit) {
    /* manage events */
    while (SDL_PollEvent(&e)) {
      /* process your events */
      quit = process(win, ren, env, &e);
      if (quit) break;
    }

    /* render all what you want */
    render(win, ren, env);
    SDL_RenderPresent(ren);
    SDL_Delay(DELAY);
  }

  /* clean your environment */
  clean(win, ren, env);

  SDL_DestroyRenderer(ren);
  SDL_DestroyWindow(win);
  IMG_Quit();
  TTF_Quit();
  SDL_Quit();

  return EXIT_SUCCESS;
}
