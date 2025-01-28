// Optional: Add animations or other interactivity if needed
document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll(".cta-button, .nav-links a, .step");

    buttons.forEach((button) => {
        button.addEventListener("mouseover", () => {
            button.style.transition = "transform 0.3s ease";
            button.style.transform = "scale(1.05)";
        });

        button.addEventListener("mouseout", () => {
            button.style.transition = "transform 0.3s ease";
            button.style.transform = "scale(1)";
        });
    });
});
