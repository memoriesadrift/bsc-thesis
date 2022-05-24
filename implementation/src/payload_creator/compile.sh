gcc main.c \
    -Wall -Wextra -Wpedantic \
    -Wformat=2 -Wno-unused-parameter -Wshadow \
    -Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
    -Wredundant-decls -Wnested-externs -Wmissing-include-dirs \
    -Wjump-misses-init -Wlogical-op \
    -O2 \
    -o hide_payload
        
