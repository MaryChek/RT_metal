# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/31 21:27:46 by kcharla           #+#    #+#              #
#    Updated: 2020/09/08 07:19:47 by kcharla          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= RT

CC			:= gcc
DEBUG		:= -g
OPTIM		:= -O2

LIBS		:= -L ./lib/mlx -lmlx -L ./lib/ft -lft -framework OpenGL -framework AppKit
INCLUDE		:= -I ./inc -I ./lib/mlx/inc -I ./lib/ft/inc

COMPILE		= $(CC) -Wall -Wextra -Wall $(DEBUG) $(OPTIM) $(INCLUDE)

BUILD_DIR	:= build
SRC_DIR		:= src

### Directories search
SRC_DIRS	= $(shell find $(SRC_DIR) -type d)
BUILD_DIRS	= $(patsubst $(SRC_DIR)%, $(BUILD_DIR)%, $(SRC_DIRS))

### Sources

# find src -type f -name '*.c' | sort | column -c 100 | sed 's/$/ \\\\/'
SRC_FILES	:= \
src/err/rt_err.c                src/gui/coroutine_example.c     src/rtc/rt_init.c \
src/fio/fio_zip_load.c          src/gui/rt_editor_drag_file.c   src/rtc/rt_loop.c \
src/fio/fio_zip_save.c          src/main.c \

OBJ			= $(patsubst $(SRC_DIR)%.c, $(BUILD_DIR)%.o, $(SRC_FILES))

# find inc -type f -name '*.h' | sort | column -c 100 | sed 's/$/ \\\\/'
HEADERS		:= \
inc/fio.h       inc/gui.h       inc/rt.h        inc/rt_s.h \

### Library files
LIB_MLX		:= ./lib/mlx/libmlx.dylib
LIB_MLX_FILE = libmlx.dylib

LIB_FT		:= ./lib/ft/libft.a

### Main Makefile

.PHONY: all clean fclean re

all: $(NAME)

# TODO remove LIB_MLX_FILE
$(NAME): $(LIB_MLX) $(LIB_FT) $(BUILD_DIRS) $(OBJ)    $(LIB_MLX_FILE)
	$(COMPILE) $(LIBS) $(OBJ) -o $(NAME)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(COMPILE) -c $< -o $@

$(BUILD_DIRS):
	@mkdir -vp $(BUILD_DIRS)

cleanl:
	@rm -rf $(BUILD_DIR)

clean: cleanl
	@make clean -C ./lib/mlx
	@make clean -C ./lib/ft

fcleanl: cleanl
	@rm -f $(NAME)
	@rm -f $(LIB_MLX_FILE)

fclean: clean fcleanl
	@make fclean -C ./lib/mlx
	@make fclean -C ./lib/ft

rel: fcleanl all

re: fclean all

lib:
	git submodule update --init --recursive

$(LIB_MLX): lib
	@make -C ./lib/mlx

# TODO: link with LD!
$(LIB_MLX_FILE): $(LIB_MLX)
	@echo 'Copying file libmlx.dylib...'
	cp $(LIB_MLX) .

$(LIB_FT): lib
	@make -C ./lib/ft
