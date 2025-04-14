#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <ClassName> <ExecName> <ExoNb>"
  exit 1
fi

CLASS_NAME=$1
EXEC_NAME=$2
EXO_NB=$3
GREEN="\e[1;32m"
RESET="\e[0m"

# main.cpp
cat <<EOF > main.cpp
#include "${CLASS_NAME}.hpp"
#include <iomanip>

void printHeader(const std::string& str)
{
	int size = 50;
	int totalPad = size - str.size();
	(totalPad < 0) ? totalPad = 0 : totalPad;
	int lPad = totalPad / 2;
	int rPad = totalPad - lPad;

	std::cout << std::endl << SMGREEN;
	std::cout << std::setfill('=') << std::setw(size) << "" << std::endl;
	std::cout << std::setfill(' ') << std::setw(lPad + str.size()) << str << std::setw(rPad) << "" << std::endl;
	std::cout << std::setfill('=') << std::setw(size) << "" << std::endl;
	std::cout << RESET << std::endl;
}

int main(void)
{

    return 0;
}
EOF

echo -e "${GREEN}✔️  main.cpp created with #include \"${CLASS_NAME}.hpp\"${RESET}"

cat <<EOF > Makefile
RESET				= \e[0m\033[0m
GREEN				= \033[0;32m\e[1m

NAME = ${EXEC_NAME}

CC					= c++
FLAGS				= -Wall -Wextra -Werror -g3 -std=c++98 -MMD -MP

SRC_DIR				= .
SRCS				= main.cpp ${CLASS_NAME}.cpp

RM					= rm -rf
OBJS_DIR			= ./objs/

OBJS_FILES 			= \${SRCS:.cpp=.o}

OBJS				= \${addprefix \${OBJS_DIR}, \${OBJS_FILES}}

DEPS				= \${OBJS:.o=.d}

\${OBJS_DIR}%.o: \${SRC_DIR}/%.cpp
	@mkdir -p \${@D}
	@\${CC} \${FLAGS} -c \$< -o \$@

\${NAME}: \${OBJS}
	@\${CC} \${FLAGS} \${OBJS} -o \${NAME}
	@echo "\${GREEN}${EXO_NB}		: DONE!\${RESET}"

all: \${NAME}

clean:
	@\${RM} \${OBJS_DIR} \${DEPS}
	@echo "\${GREEN}Clean		: DONE!\${RESET}"

fclean: clean
	@\${RM} \${NAME}
	@echo "\${GREEN}Full Clean	: DONE!\${RESET}"

-include \${DEPS}

re: fclean all

.PHONY: all clean fclean re
EOF

echo -e "${GREEN}✔️  Makefile created with NAME=${EXEC_NAME}${RESET}"
