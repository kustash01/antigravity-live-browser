# Инструкция для Antigravity (Агента)

Скопируйте этот блок в ваш `AGENTS.md` или `CLAUDE.md`:

```markdown
# 31. WEB BROWSING & LIVE REAL-TIME AUTOMATION

When the user requests web navigation, browsing, clicking, or inspecting websites:

1. NEVER write throwaway Python, Node.js, Playwright, or Selenium scripts.
2. Always use the interactive real-time browser:
   * Launch via task scheduler: `schtasks /run /tn "AgentChromium"` (uses ultra-performance flags, hardware GPU rasterization, zero background throttling).
   * Note: Do NOT automatically restart the browser if closed by the user.
   * Control the browser immediately via CDP: `agent-browser --cdp 9222 <command>`.
   * Always use IPv4 `127.0.0.1` instead of `localhost` to eliminate IPv6 resolution delay.
3. Event-Driven DOM Observers (NO SLEEP / NO ARBITRARY WAITING):
   * NEVER use fixed sleeps (`wait 2000` / `sleep 2`). Wait for `domcontentloaded` or DOM mutation.
   * Use event-driven MutationObserver hooks that resolve the exact millisecond an element appears in the DOM.
   * Avoid waiting for `networkidle` on sites with persistent websockets or analytics beacons (FunPay, Avito, etc.); proceed immediately when DOM is interactive.
4. Chain commands using `&&` for instant execution (turbo mode):
   * Example: `agent-browser --cdp 9222 open <url> && agent-browser --cdp 9222 snapshot -i && agent-browser --cdp 9222 click @ref`
5. Semantic Locators & Robust Fallbacks:
   * Prefer semantic locators (`role`, `aria-label`, visible text, refs from `snapshot -i`).
   * If a selector fails, fall back to searching by visible text or accessibility role.
6. Downloads & Profiles:
   * Target downloads to `c:\VibeCode\downloads`.
   * Persistent user profile stored at `%USERPROFILE%\.gemini\browser_profile`.
   * Multi-profile support via `start_browser.bat [profile_name]`.
7. Execute commands with `WaitMsBeforeAsync: 10000` to prevent unnecessary background task drops.

---

# 32. ULTRA-PERFORMANCE EXECUTION & LATENCY ELIMINATION (ZERO INTELLIGENCE LOSS)

1. Uncompromising Intelligence:
   * NEVER decrease the depth of reasoning, model thinking budget, or thoroughness of verification to save seconds.
   * Speed is gained through infrastructure latency elimination, parallel dispatch, and direct protocols — NOT shallow thinking.
2. Parallel Batch Tool Dispatch:
   * When a task requires inspecting multiple files, reading documentation, or running independent checks, dispatch them CONCURRENTLY in a single turn.
   * Avoid serial round-trips for independent operations.
3. Fast AST Navigation:
   * Prefer AST-indexed navigation via Serena MCP (`find_symbol`, `get_symbols_overview`) over brute-force file scanning for code structure and symbols.
4. Windows Kernel & Filesystem Efficiency:
   * Avoid spawning redundant shell wrappers (`cmd /c powershell /c ...`). Execute commands directly.
   * Rely on Git filesystem caching (`core.untrackedcache`, `core.fscache`, `core.preloadindex`).
```
