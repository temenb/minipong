.PHONY: proto-generate

proto-generate:
	@echo '🚀 Proto generate...'

	@#command -v protoc >/dev/null 2>&1 || { echo "❌ protoc не найден. Установите его (apt install protobuf-compiler или brew install protobuf)."; exit 1; }
	@for dir in $(NODE_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		rm -rf $(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH}; \
		mkdir -p $(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH}; \
	done

	@for dir in $(FLUTTER_SERVICES); do \
		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
		rm -rf $(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH}; \
		mkdir -p $(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH}; \
	done

	@npx --no-install protoc --version >/dev/null 2>&1 || { \
		echo "❌ protoc не найден в node_modules/.bin или глобально"; \
		exit 1; \
	}

	@for dir in $(NODE_SERVICES); do \
		echo "\033[1;34m[>] Generating proto for $$dir...\033[0m"; \
		npx protoc \
			--plugin=./node_modules/.bin/protoc-gen-ts_proto \
			--ts_proto_out=$(BASE_DIR)/$(SERVICE_DIR)/$$dir/${NODE_PROTO_PATH} \
			--ts_proto_opt=outputServices=grpc-js,useExactTypes=false,esModuleInterop=true \
			--proto_path=./proto \
			$(PROTO_FILES); \
		echo "\033[1;32m[✓] $$dir done\033[0m"; \
	done

	@command -v protoc >/dev/null 2>&1 || { \
		echo "❌ protoc не найден. Установите его (apt install protobuf-compiler или brew install protobuf)."; \
		exit 1; \
	}

	@for dir in $(FLUTTER_SERVICES); do \
		echo "\033[1;34m[>] Generating proto for $$dir...\033[0m"; \
		protoc \
			--dart_out=grpc:$(BASE_DIR)/$(SERVICE_DIR)/$$dir/${FLUTTER_PROTO_PATH} \
			--proto_path=./proto \
			$(PROTO_FILES); \
		echo "\033[1;32m[✓] $$dir done\033[0m"; \
	done



