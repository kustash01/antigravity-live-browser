/**
 * Event-Driven MutationObserver Hook for CDP / Browser Automation
 * 
 * Resolves the exact millisecond an element appears in the DOM.
 * Eliminates artificial sleep / poll cycles.
 * 
 * Usage in CDP / evaluate:
 *   await waitForSelector('.my-target-class', 5000);
 */

function waitForSelector(selector, timeoutMs = 5000) {
  return new Promise((resolve, reject) => {
    const existing = document.querySelector(selector);
    if (existing) {
      return resolve({ element: existing, elapsedMs: 0 });
    }

    const start = performance.now();
    let timer = null;

    const observer = new MutationObserver(() => {
      const el = document.querySelector(selector);
      if (el) {
        observer.disconnect();
        if (timer) clearTimeout(timer);
        resolve({ element: el, elapsedMs: performance.now() - start });
      }
    });

    observer.observe(document.documentElement, {
      childList: true,
      subtree: true,
      attributes: true
    });

    if (timeoutMs > 0) {
      timer = setTimeout(() => {
        observer.disconnect();
        reject(new Error(`Timeout of ${timeoutMs}ms waiting for selector: "${selector}"`));
      }, timeoutMs);
    }
  });
}

if (typeof module !== 'undefined') {
  module.exports = { waitForSelector };
}
