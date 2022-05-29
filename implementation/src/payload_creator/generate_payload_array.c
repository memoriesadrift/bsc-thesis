#include <stddef.h>
#include <stdio.h>  // printf, FILE, fread
#include <stdlib.h> // NULL, exit, size_t
#include <string.h> // strlen, strncmp

const char *usage_error =
    "Usage: ./generate_payload_array payload.exe > dest.js\n";

int check_inputs(char *args[]) {
  const char *arg1_extension = &args[1][strlen(args[1]) - 4];

  if (strncmp(arg1_extension, ".exe", 4) != 0) {
    return 0;
  }

  return 1;
}

// File Loading with error checking
FILE *load_file(const char *filename, const char *opts) {
  FILE *file = fopen(filename, opts);

  if (file == NULL) {
    printf("Error reading file %s, exiting... \n", filename);
    exit(1);
  }

  return file;
}

int print_array(FILE *file) {
  size_t read;
  unsigned short buffer[8192];

  // Use var over const because MS JScript doesn't always support it
  printf("var data = [\n  ");
  do {
    read = fread(buffer, 2, sizeof buffer / 2, file);
    for (size_t i = 0; i < read; i++) {
      printf("%d, ", buffer[i]);
      if (i % 10 == 0 && i != 0) {
        printf("\n  ");
      }
    }
  } while (read > 0);

  printf("\n]\n");
  return 1;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("%s", usage_error);
    return 1;
  }

  if (!check_inputs(argv)) {
    printf("%s", usage_error);
    return 1;
  }

  FILE *payload = load_file(argv[1], "rb");

  print_array(payload);
  fclose(payload);

  return 0;
}
