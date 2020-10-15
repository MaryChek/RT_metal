# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/31 21:27:46 by kcharla           #+#    #+#              #
#    Updated: 2020/10/12 22:56:55 by kcharla          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= RT

CC			:= gcc
DEBUG		:= -g
OPTIM		:= -O2

LIBS		:= -L ./lib/mlx -lmlx -L ./lib/num -lnum -L ./lib/ft -lft -framework AppKit
INCLUDE		:= -I ./inc -I ./lib/mlx/inc -I ./lib/ft/inc -I ./lib/num/include

COMPILE		= $(CC) -Wall -Wextra -Wall $(DEBUG) $(OPTIM) $(INCLUDE)

BUILD_DIR	:= build
SRC_DIR		:= src

### Directories search
SRC_DIRS	= $(shell find $(SRC_DIR) -type d)
BUILD_DIRS	= $(patsubst $(SRC_DIR)%, $(BUILD_DIR)%, $(SRC_DIRS))

### Sources

# find src -type f -name '*.c' | sort | column -c 100 | sed 's/$/ \\\\/'
SRC_FILES	:= \
src/err/rt_err.c                src/gui/coroutine_example.c     src/rtc/rtc_init.c \
src/err/rt_warn.c               src/gui/rt_editor_drag_file.c   src/rtc/rtc_loop.c \
src/fio/fio_read_file.c         src/main.c                      src/rtc/rtc_scn.c \
src/fio/fio_read_files.c        src/rt_init.c                   src/rts/rts_free.c \
src/fio/fio_zip_load.c          src/rt_loop.c                   src/rts/rts_init.c \
src/fio/fio_zip_save.c          src/rtc/rtc_id_manager.c \


OBJ			= $(patsubst $(SRC_DIR)%.c, $(BUILD_DIR)%.o, $(SRC_FILES))

# find inc -type f -name '*.h' | sort | column -c 100 | sed 's/$/ \\\\/'
HEADERS		:= \
inc/err.h               inc/metal_shader.h      inc/rtc_scn.h \
inc/fio.h               inc/rt.h                inc/rtc_scn_obj.h \
inc/gui.h               inc/rtc.h               inc/rts.h \

### Library files
LIB_MLX		:= ./lib/mlx/libmlx.dylib
LIB_MLX_FILE = libmlx.dylib

LIB_FT		:= ./lib/ft/libft.a
LIB_NUM		:= ./lib/num/libnum.a

### Main Makefile

.PHONY: all clean fclean re

all: $(NAME)

# TODO remove LIB_MLX_FILE
# TODO fancy ld description
$(NAME): $(LIB_MLX) $(LIB_FT) $(LIB_NUM) $(BUILD_DIRS) $(OBJ)
	ld -e _main -lc -o RT $(OBJ) $(LIBS)
# 	$(COMPILE) $(LIBS) $(OBJ) -o $(NAME) -ldflags "-headerpad"
	install_name_tool -add_rpath @executable_path/lib/mlx/. RT
	install_name_tool -change libmlx.dylib @rpath/libmlx.dylib RT

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

link:
	rm -f $(NAME)
	make all

$(LIB_MLX): lib
	@make -C ./lib/mlx

# TODO: link with LD!
# $(LIB_MLX_FILE): $(LIB_MLX)
# 	@echo 'Copying file libmlx.dylib...'
# 	cp $(LIB_MLX) .

$(LIB_FT): lib
	@make -C ./lib/ft

$(LIB_NUM): lib
	@make -C ./lib/num
