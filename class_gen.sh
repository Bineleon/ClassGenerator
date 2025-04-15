#!/bin/bash

if [ -z "$1" ]; then
    echo "Format: $0 ClassName"
    exit 1
fi

CLASS_NAME=$1
HEADER_FILE="${CLASS_NAME}.hpp"
SOURCE_FILE="${CLASS_NAME}.cpp"
INCLUDE_GUARD="$(echo ${CLASS_NAME}_HPP | tr '[:lower:]' '[:upper:]')"
GREEN="\e[1;32m"
RESET="\e[0m"

# .hpp

cat <<EOF > $HEADER_FILE
#ifndef ${INCLUDE_GUARD}
#define ${INCLUDE_GUARD}

#include <iostream>

class ${CLASS_NAME}
{
    public:
        ${CLASS_NAME}(void);
        ${CLASS_NAME}(const ${CLASS_NAME}& src);
        ${CLASS_NAME}& operator=(const ${CLASS_NAME}& rhs);
        ~${CLASS_NAME}(void);

    private:

};

# define RESET "\033[0m"
# define SMRED "\033[0;31m"
# define SMGREEN "\033[0;32m"
# define SMYELLOW "\033[0;33m"
# define SMBLUE "\033[0;34m"
# define SMMAGENTA "\033[0;35m"
# define SMCYAN "\033[0;36m"

# define RED "\033[1;31m"
# define GREEN "\033[1;32m"
# define YELLOW "\033[1;33m"
# define BLUE "\033[1;34m"
# define MAGENTA "\033[1;35m"
# define CYAN "\033[1;36m"

#endif
EOF

# .cpp

cat <<EOF > $SOURCE_FILE
#include "${HEADER_FILE}"

${CLASS_NAME}::${CLASS_NAME}(void)
{
    std::cout << "${CLASS_NAME} default constructor called" << std::endl;
}

${CLASS_NAME}::${CLASS_NAME}(const ${CLASS_NAME}& src)
{
    std::cout << "${CLASS_NAME} copy constructor called" << std::endl;
    *this = src;
}

${CLASS_NAME}& ${CLASS_NAME}::operator=(const ${CLASS_NAME}& rhs)
{
    std::cout << "${CLASS_NAME} copy assignment operator called" << std::endl;
        // copy attributs here
    return *this;
}

${CLASS_NAME}::~${CLASS_NAME}(void)
{
    std::cout << "${CLASS_NAME} destructor called" << std::endl;
}
EOF

echo -e "${GREEN}✔️  ${HEADER_FILE} and ${SOURCE_FILE} created successfully.${RESET}"
