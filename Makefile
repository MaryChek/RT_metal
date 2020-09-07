# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kcharla <kcharla@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/31 21:27:46 by kcharla           #+#    #+#              #
#    Updated: 2020/09/02 23:52:11 by kcharla          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= RT

CC			:= gcc
DEBUG		:= -g
OPTIM		:= -O2

LIBS		:= -L ./lib/mgx -lmgx -framework OpenGL -framework AppKit
INCLUDE		:= -I ./inc -I ./lib/mgx/inc

COMPILE		= $(CC) -Wall -Wextra -Wall $(DEBUG) $(OPTIM) $(INCLUDE)

BUILD_DIR	:= build
SRC_DIR		:= src

### Directories search
SRC_DIRS	= $(shell find $(SRC_DIR) -type d)
BUILD_DIRS	= $(patsubst $(SRC_DIR)%, $(BUILD_DIR)%, $(SRC_DIRS))

### Sources

# find src -type f -name '*.c' | sort | column -c 100 | sed 's/$/ \\\\/'
SRC_FILES	:= \
src/fio/load.c                  src/main.c \
src/gui/coroutine_example.c     src/rt_loop.c \

OBJ			= $(patsubst $(SRC_DIR)%.c, $(BUILD_DIR)%.o, $(SRC_FILES))

# find inc -type f -name '*.h' | sort | column -c 100 | sed 's/$/ \\\\/'
HEADERS		:= \
inc/rt.h                inc/rt_coroutines.h     inc/rt_s.h \

### Library files
LIB_MGX		:= ./lib/mgx/libmgx.a

### Main Makefile

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(LIB_MGX) $(BUILD_DIRS) $(OBJ)
	$(COMPILE) $(LIBS) $(OBJ) -o $(NAME)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(COMPILE) -c $< -o $@

$(BUILD_DIRS):
	@mkdir -vp $(BUILD_DIRS)

cleanl:
	@rm -rf $(BUILD_DIR)

clean: cleanl
	@make clean -C ./lib/mgx

fcleanl: cleanl
	@rm -f $(NAME)

fclean: clean fcleanl
	@make fclean -C ./lib/mgx

rel: fcleanl all

re: fclean all

$(LIB_MGX):
	@make -C ./lib/mgx
