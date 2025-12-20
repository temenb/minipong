.PHONY: git-commit-and-push-all git-commit-all git-push-all


git-commit-and-push-all:
	@echo "🚀 Commit all repos..."
	@meke commit-all
	@echo "🚀 Push all repos..."
	@make push-all

git-commit-all:
	@#for dir in $(GIT_SERVICES); do \
#		echo "\033[1;33m[*] Checking $$dir...\033[0m"; \
#		SERVICE_PATH="$(BASE_DIR)/$(SERVICE_DIR)/$$dir"; \
##		echo $$SERVICE_PATH; \
#		cd "$$SERVICE_PATH"; \
#		if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then \
#			echo "\033[0;31m[!] Skipping $$dir — invalid git repo\033[0m"; \
#			cd - >/dev/null; \
#			continue; \
#		fi; \
#		if [ -z "$$(git status --porcelain)" ]; then \
#			echo "\033[1;33m[-] No changes in $$dir\033[0m"; \
#		else \
#			echo "\033[1;32m[+] Committing changes in $$dir...\033[0m"; \
#			git add . && \
#			git commit -m "$(COMMIT_MSG)" && \
#			echo "git commit -m \"$(COMMIT_MSG)\""; \
#		fi; \
#		cd - >/dev/null; \
#	done


	@#echo "\033[1;33m[*] Checking monorepo...\033[0m"; \
	cd "$(BASE_DIR)"; \
	if git diff --quiet; then \
		echo "\033[1;33m[-] No changes in monorepo\033[0m"; \
	else \
		git add . && \
		git commit -am "$(COMMIT_MSG)" && \
		echo "git commit -am \"$(COMMIT_MSG)\""; \
	fi;

git-push-all:
	@for dir in $(GIT_SERVICES); do \
		echo "\033[1;34m[*] Pushing $$dir...\033[0m"; \
		SERVICE_PATH="$(SERVICE_DIR)/$$dir"; \
		cd "$$SERVICE_PATH"; \
		if git push; then \
			echo "\033[0;32m[✓] Pushed $$dir\033[0m"; \
		else \
			echo "\033[0;31m[✗] Failed to push $$dir\033[0m"; \
		fi; \
		cd - > /dev/null; \
	done

	@echo "\033[1;34m[*] Pushing monorepo...\033[0m"
	if git push; then \
		echo "\033[0;32m[✓] Pushed monorepo\033[0m"; \
	else \
		echo "\033[0;31m[✗] Failed to push monorepo\033[0m"; \
	fi; \

