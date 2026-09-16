# Antigravity Live Real-Time Browser Suite

🌐 **Real-time visible browser automation for Antigravity AI agents on Windows.**

Watch your AI agent navigate, fill forms, search, click buttons, and inspect websites in a visible, live Chromium window on your physical desktop — with zero script generation lag.

---

## 💡 The Core Problem It Solves

On Windows, developer agent runtimes (like Antigravity) execute child terminal processes inside an isolated Windows station desktop (`exebox-...`) to prevent CLI processes from stealing user keyboard/mouse focus. 

When an agent attempts standard headless/headed browser automation:
1. The browser window renders into an invisible sandbox virtual desktop (`exebox`), never showing on your monitor.
2. The agent falls back to generating throwaway Python or Playwright scripts, incurring 15–30s of script compilation, process startup, and error handling latency.

---

## ⚡ The Architecture Solution

```
┌──────────────────────────────────────────────────────────┐
│                   Windows User Desktop                   │
│                    (winsta0\Default)                     │
│                                                          │
│   ┌──────────────────────────────────────────────────┐   │
│   │           Visible Chromium Browser Window        │   │
│   │        Remote Debugging CDP on 127.0.0.1:9222    │   │
│   └────────────────────────▲─────────────────────────┘   │
└────────────────────────────┼─────────────────────────────┘
                             │ Chrome DevTools Protocol (CDP)
┌────────────────────────────┴─────────────────────────────┐
│                 Antigravity AI Agent                     │
│                                                          │
│   1. schtasks /run /tn "AgentChromium"                   │
│      (Bypasses sandbox -> launches on user monitor)      │
│   2. agent-browser --cdp 9222 <commands>                 │
│      (Instant sub-100ms actions chained with &&)         │
└──────────────────────────────────────────────────────────┘
```

1. **Windows Task Scheduler Integration (`schtasks`)**:
   Launches the browser with the interactive flag (`/it`) onto `winsta0\Default`. The browser opens physically on your active display.
2. **Direct Chrome DevTools Protocol (CDP)**:
   The agent communicates directly over port `9222` using fast CDP clients (`agent-browser` or Playwright MCP) in sub-100ms turnarounds.
3. **Command Chaining (Turbo Mode)**:
   Actions are concatenated with `&&` (`open url && snapshot -i && click @e1`), executing entire workflows in 1-2 seconds.

---

## 🌟 Key Features

* 👁️ **100% Headed & Visible**: Watch every click, keystroke, and page load happen in real time.
* ⚡ **Zero-Script Execution**: Direct CDP control without writing temporary `.py` or `.js` script files.
* 🎯 **Semantic Fallback Locators**: If exact CSS selectors change, automatically locates buttons and inputs by accessibility roles and visible text.
* 💾 **Persistent Multi-Profiles**: Preserves user logins, sessions, and cookies (`.gemini/browser_profile`). Supports named profiles (`start_browser.bat [profile_name]`).
* 📁 **Project Downloads Folder**: Automatically targets browser downloads to `./downloads/`.
* 🛡️ **User-Centric Lifecycle**: Does not auto-restart if the user explicitly closes the window.

---

## 🚀 Quick Setup

### Step 1: Register Task Scheduler Task
Run once as Administrator or standard user:
```bat
setup_scheduler_task.bat
```

### Step 2: Add Agent Rule to your Project
Copy the contents of `AGENTS_RULE.md` to the end of your workspace `AGENTS.md`.

### Step 3: Enjoy Live Automation!
Ask your agent to perform any web task:
> *"Open YouTube, search for Google DeepMind and click on the latest video"*

The browser pops up on your screen and the agent acts live.

---

## 📂 Repository Contents

* `start_browser.bat`: Core browser launcher supporting profiles, custom URLs, and download routing.
* `setup_scheduler_task.bat`: Script to register the `AgentChromium` task in Windows Task Scheduler.
* `AGENTS_RULE.md`: Drop-in instructions for `AGENTS.md` in any Antigravity workspace.
* `downloads/`: Target directory for all browser-downloaded files.

---

## 📄 License
MIT License. Created for high-performance agentic workflows.
