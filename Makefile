CC ?= gcc
CFLAGS_common ?= -O0 -Wall -std=gnu99

EXEC = phonebook_orig phonebook_opt phonebook_opt2
all: $(EXEC)

SRCS_common = main.c

phonebook_orig: $(SRCS_common) phonebook_orig.c phonebook_orig.h
	$(CC) $(CFLAGS_common) -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

phonebook_opt: $(SRCS_common) phonebook_opt.c phonebook_opt.h
	$(CC) $(CFLAGS_common) -DOPT -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c
		
phonebook_opt2: $(SRCS_common) phonebook_opt2.c phonebook_opt2.h
	$(CC) $(CFLAGS_common) -DOPT -DIMPL="\"$@.h\"" -o $@ \
		$(SRCS_common) $@.c

run: $(EXEC)
	@echo "=== Origin ==="
	@echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	@./phonebook_orig
	@echo "=== Character Index ==="
	@echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	@./phonebook_opt
	@echo "=== Hash Index ==="
	@echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	@./phonebook_opt

plot_miss: $(EXEC)
	@bash ./plot_scripts/plotmiss.sh

plot_append: $(EXEC)
	@bash ./plot_scripts/plotappend.sh
	
plot_find: $(EXEC)
	@bash ./plot_scripts/plotfind.sh
	
clean:
	$(RM) $(EXEC) *.o *.png
