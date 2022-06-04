#include <stdio.h>  // printf, FILE, SEEK_END, fseek, fwrite, fread
#include <stdlib.h> // NULL, exit
#include <string.h> // strlen, strncmp

const char *usage_error = "Usage: ./hide_payload image.png payload.zip\n";

int check_inputs(char *args[]) {
  const char *arg1_extension = &args[1][strlen(args[1]) - 4];
  const char *arg2_extension = &args[2][strlen(args[2]) - 4];

  if (strncmp(arg1_extension, ".png", 4) != 0 ||
      strncmp(arg2_extension, ".zip", 4) != 0) {
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

// TODO: keep a copy of the file to revert to if something goes wrong?
int hide_payload(FILE *image, FILE *executable) {
  unsigned long read, wrote;
  unsigned char buffer[8192];

  fseek(image, 0, SEEK_END);
  fseek(executable, 3, SEEK_SET);
  do {
    read = fread(buffer, 1, sizeof buffer, executable);
    wrote = fwrite(buffer, 1, read, image);

    // Indicates an error while writing
    if (wrote != read) {
      return 0;
    }
  } while ((read > 0));

  return 1;
}

int main(int argc, char *argv[]) {
  if (argc != 3) {
    printf("%s", usage_error);
    return 1;
  }

  if (!check_inputs(argv)) {
    printf("%s", usage_error);
    return 1;
  }

  FILE *image = load_file(argv[1], "ab");
  FILE *payload = load_file(argv[2], "rb");

  int success = hide_payload(image, payload);

  fclose(image);
  fclose(payload);

  if (!success) {
    printf("Error writing to file.");
    return 1;
  }

  printf("Success!\n");
  return 0;
}
