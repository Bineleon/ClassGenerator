#!/bin/bash

if [ -z "$1" ]; then
    echo "Format: $0 ClassName"
    exit 1
fi

CLASS_NAME=$1
HEADER_FILE="${CLASS_NAME}.hpp"
SOURCE_FILE="${CLASS_NAME}.cpp"
INCLUDE_GUARD="$(echo ${CLASS_NAME}_HPP | tr '[:lower:]' '[:upper:]')"

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

#endif // ${INCLUDE_GUARD}
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
        // copy members here
    return *this;
}

${CLASS_NAME}::~${CLASS_NAME}(void)
{
    std::cout << "${CLASS_NAME} destructor called" << std::endl;
}
EOF

echo "\e[32m${HEADER_FILE} and ${SOURCE_FILE} created successfully.\e[0m"
