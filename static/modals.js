document.addEventListener('DOMContentLoaded', () => {
    // -------------------------------------------------------------
    // 1. LOGIN MODAL LOGIC
    // -------------------------------------------------------------
    const loginModal = document.getElementById('login-modal');
    const closeLoginBtn = document.getElementById('close-login-btn');
    const cancelLoginBtn = document.getElementById('cancel-login-btn');

    // Function to open the login modal
    window.openLoginModal = () => {
        if (loginModal) {
            loginModal.classList.remove('hidden');
            // Small timeout to allow the transition effect to kick in cleanly
            setTimeout(() => {
                loginModal.firstElementChild.classList.remove('scale-95');
                loginModal.firstElementChild.classList.add('scale-100');
            }, 10);
        }
    };

    // Function to close the login modal
    window.closeLoginModal = () => {
        if (loginModal) {
            loginModal.firstElementChild.classList.remove('scale-100');
            loginModal.firstElementChild.classList.add('scale-95');
            setTimeout(() => {
                loginModal.classList.add('hidden');
            }, 150); // Matches transition-all duration
        }
    };

    if (closeLoginBtn) closeLoginBtn.addEventListener('click', window.closeLoginModal);
    if (cancelLoginBtn) cancelLoginBtn.addEventListener('click', window.closeLoginModal);


    // -------------------------------------------------------------
    // 2. QUICK VIEW MODAL LOGIC
    // -------------------------------------------------------------
    const qvModal = document.getElementById('quick-view-modal');
    const closeQvBtn = document.getElementById('close-qv-btn');
    const closeQvSecondaryBtn = document.getElementById('close-qv-secondary-btn');

    // Function to show and populate the Quick View Modal
    window.openQuickView = (movieData) => {
        if (!qvModal) return;

        // Populate modal elements with dynamic movie data
        document.getElementById('qv-title').textContent = movieData.title || 'Movie Details';
        document.getElementById('qv-image').src = movieData.image_url || 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1000';
        document.getElementById('qv-rating-val').textContent = movieData.rating || '--';
        document.getElementById('qv-year').textContent = movieData.release_year || '----';
        document.getElementById('qv-genre').textContent = movieData.genre || 'N/A';
        document.getElementById('qv-director').querySelector('span').textContent = movieData.director || 'Unknown';
        document.getElementById('qv-description').textContent = movieData.description || 'No summary available.';
        
        // Dynamic link to the full details page
        document.getElementById('qv-full-details-btn').href = `/movie/${movieData.id}`;

        // Show the modal
        qvModal.classList.remove('hidden');
        setTimeout(() => {
            qvModal.firstElementChild.classList.remove('scale-95');
            qvModal.firstElementChild.classList.add('scale-100');
        }, 10);
    };

    // Function to close the Quick View Modal
    window.closeQuickView = () => {
        if (qvModal) {
            qvModal.firstElementChild.classList.remove('scale-100');
            qvModal.firstElementChild.classList.add('scale-95');
            setTimeout(() => {
                qvModal.classList.add('hidden');
            }, 150);
        }
    };

    if (closeQvBtn) closeQvBtn.addEventListener('click', window.closeQuickView);
    if (closeQvSecondaryBtn) closeQvSecondaryBtn.addEventListener('click', window.closeQuickView);


    // -------------------------------------------------------------
    // 3. GLOBAL CLICK-OUTSIDE-TO-CLOSE LOGIC
    // -------------------------------------------------------------
    window.addEventListener('click', (event) => {
        if (event.target === loginModal) {
            window.closeLoginModal();
        }
        if (event.target === qvModal) {
            window.closeQuickView();
        }
    });
});