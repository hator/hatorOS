#include <util.h>

void* memset(char* ptr, int value, size_t num)
{
	size_t i;
	unsigned char v = (unsigned char)value;
	for(i = 0; i < num; i++)
		ptr[i] = v;
	return (void*)ptr;
}
