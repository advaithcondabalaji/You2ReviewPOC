document.addEventListener('DOMContentLoaded', () => {
    console.log("MovieSphere application scripts successfully loaded!");

    // 1. Hook up Quick View Buttons
    // This looks for any button or element with the attribute 'data-quick-view'
    const quickViewTriggers = document.querySelectorAll('[data-quick-view]');
    
    quickViewTriggers.forEach(trigger => {
        trigger.addEventListener('click', (e) => {
            e.preventDefault();
            
            // Extract the serialized movie data from the HTML data attribute
            try {
                const rawData = trigger.getAttribute('data-movie');
                const movieData = JSON.parse(rawData);
                
                if (window.openQuickView) {
                    window.openQuickView(movieData);
                }
            } catch (error) {
                console.error("Failed to parse movie data for quick view:", error);
            }
        });
    });

    // 2. Navigation / Login Trigger Helper
    // If you add a "Sign In" link in your base.html nav, this handles bringing up the modal
    const loginTrigger = document.getElementById('nav-login-trigger');
    if (loginTrigger) {
        loginTrigger.addEventListener('click', (e) => {
            e.preventDefault();
            if (window.openLoginModal) {
                window.openLoginModal();
            }
        });
    }
});