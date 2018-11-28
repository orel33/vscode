// SDL2 Mandelbrot Demo by aurelien.esnard@u-bordeaux.fr
// https://rosettacode.org/wiki/Mandelbrot_set

#include <SDL.h>

#include <assert.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define min_f(a, b, c) (fminf(a, fminf(b, c)))
#define max_f(a, b, c) (fmaxf(a, fmaxf(b, c)))

#define APP_NAME "Mandelbrot"
#define DELAY 100
#define SCREEN_DIM 500
#define DIM 500
#define MAXITER 4096

#define XMIN -2.0
#define XMAX 1.0
#define YMIN -1.0
#define YMAX 1.0

// #define XMIN -0.2395
// #define XMAX -0.2275
// #define YMIN 0.648
// #define YMAX 0.660

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

/* row i and col j */
uint32_t mandelbrot(float xMin, float xMax, float yMin, float yMax, int xPixels,
                    int yPixels, int maxIter, int i, int j) {
  assert(xPixels > 0 && yPixels > 0);
  assert(i >= 0 && i < xPixels && j >= 0 && j < yPixels);
  float dx = (xMax - xMin) / (float)xPixels;
  assert(dx > 0.0f);
  float dy = (yMax - yMin) / (float)yPixels;
  assert(dy > 0.0f);
  float xc = xMin + dx * j;
  float yc = yMin + dy * i;
  float x = 0.0, y = 0.0; /* Z = X+I*Y */
  uint32_t iter;
  for (iter = 0; iter < maxIter; iter++) {
    float x2 = x * x;
    float y2 = y * y;
    /* Stop iterations when |Z| > 2 */
    if (x2 + y2 > 4.0) break;
    /* Z = Z^2 + C */
    float twoxy = 2.0f * x * y;
    x = x2 - y2 + xc;
    y = twoxy + yc;
  }
  return iter;
}

/* **************************************************************** */

/* SDL interprets each pixel as a 32-bit number in RGBA format, that depends
   on the endianness (byte order) of the machine */

uint32_t rgb(uint32_t r, uint32_t g, uint32_t b) {
  assert(r >= 0 && r <= 255);
  assert(g >= 0 && g <= 255);
  assert(b >= 0 && b <= 255);

  unsigned char a = 255; /* alpha */
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
  uint32_t color = (r << 24) | (g << 16) | (b << 8) | alpha /* big endian */;
#else
  uint32_t color = (a << 24) | (b << 16) | (g << 8) | r /* little endian */;
#endif
  return color;
}

/* **************************************************************** */

uint32_t iter2rgb(uint32_t iter, uint32_t maxiter) {
  assert(iter > 0);

  float scale = log(iter) / log(maxiter);  // scale in range [0,1]
  assert(scale >= 0.0f && scale <= 1.0f);
  scale *= 3.0;

  uint32_t r, g, b;

  if (scale < 1.0f)
    r = 255 * scale, g = 0, b = 0; /* black -> red */
  else if (scale < 2.0f)
    r = 255, g = 0, b = 255 * (scale - 1.0); /* red -> magenta */
  else if (scale <= 3.0f)
    r = 255 * (3.0 - scale), g = 0, b = 255; /* magenta -> blue */
  else
    r = 0, g = 0, b = 255; /* blue */

  return rgb(r, g, b);
}

/* **************************************************************** */

uint32_t iter2grey(uint32_t iter, uint32_t maxiter) {
  assert(iter > 0);
  float scale = log(iter) / log(maxiter);  // log scale in range [0,1]
  // float scale = iter * 1.0f / maxiter;  // linear scale in range [0,1]
  assert(scale >= 0.0f && scale <= 1.0f);
  uint32_t grey = scale * 255;
  return rgb(grey, grey, grey);
}

/* **************************************************************** */

Env* init(SDL_Window* win, SDL_Renderer* ren, int argc, char* argv[]) {
  Env* env = malloc(sizeof(struct Env_t));

  struct timeval t1, t2;
  gettimeofday(&t1, NULL);
  for (int i = 0; i < DIM; i++)   /* row */
    for (int j = 0; j < DIM; j++) /* col */
    {
      uint32_t iter =
          mandelbrot(XMIN, XMAX, YMIN, YMAX, DIM, DIM, MAXITER, i, j);
      uint32_t color = iter2rgb(iter, MAXITER);
      // uint32_t color = iter2grey(iter, MAXITER);
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
         DIM, DIM, timecomp, MAXITER);

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
  SDL_Quit();

  return EXIT_SUCCESS;
}
