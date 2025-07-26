function setMetaThemeColor(color) {
    const meta = document.querySelector('meta[name="theme-color"]');
    if (meta) {
    meta.setAttribute("content", color);
    }
}