# 31. WEB BROWSING & LIVE REAL-TIME AUTOMATION

When the user requests web navigation, browsing, clicking, or inspecting websites:

1. NEVER write throwaway Python, Node.js, Playwright, or Selenium scripts.
2. Always use the interactive real-time browser:
   * Launch via task scheduler: `schtasks /run /tn "AgentChromium"`
   * Note: Do NOT automatically restart the browser if closed by the user.
   * Control the browser immediately via CDP: `agent-browser --cdp 9222 <command>`
   * Use IPv4 address `127.0.0.1` instead of `localhost` to eliminate IPv6 resolution delay.
3. Chain commands using `&&` for instant execution (turbo mode):
   * Example: `agent-browser --cdp 9222 open <url> && agent-browser --cdp 9222 snapshot -i && agent-browser --cdp 9222 click @ref`
4. Semantic Locators & Robust Fallbacks:
   * Prefer semantic locators (`role`, `aria-label`, visible text, refs from `snapshot -i`).
   * If a selector fails, fall back to searching by visible text or accessibility role.
5. Downloads & Profiles:
   * Target downloads to `downloads/`.
   * Persistent user profile stored at `%USERPROFILE%\.gemini\browser_profile`.
   * Multi-profile support via `start_browser.bat [profile_name]`.
6. Execute commands with `WaitMsBeforeAsync: 10000` to prevent unnecessary background task drops.
