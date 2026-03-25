IVERILOG ?= iverilog
VVP ?= vvp
BUILD_DIR := build
RTL_SRCS := dff.v bit.v register.v ram8.v ram64.v ram512.v ram4k.v ram16k.v pc.v
TESTS := dff bit register ram8 ram64 ram512 ram4k ram16k pc

all: test

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

define TB_template
$(BUILD_DIR)/tb_$(1).out: tb_$(1).v $(RTL_SRCS) | $(BUILD_DIR)
	$(IVERILOG) -g2012 -o $$@ $$^

.PHONY: test_$(1)
test_$(1): $(BUILD_DIR)/tb_$(1).out
	$(VVP) $$<
endef

$(foreach TB,$(TESTS),$(eval $(call TB_template,$(TB))))

.PHONY: test
test: $(TESTS:%=test_%)
	@echo "All tests completed successfully"

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)
