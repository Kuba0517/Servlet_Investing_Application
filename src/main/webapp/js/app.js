document.addEventListener('DOMContentLoaded', () => {
    console.log("super")
    const counters = document.querySelectorAll('h1[data-target]');

    counters.forEach(counter => {
        const speed = counter.id === "roi" ? 1 :
            counter.id === "customers" ? 100 :
                counter.id === "money-lost" ? 200 : 200;
        const updateCount = () => {
            const target = +counter.getAttribute('data-target');
            const count = +counter.innerText;
            const increment = target / speed;

            if (count < target) {
                counter.innerText = Math.ceil(count + increment);
                setTimeout(updateCount, 20);
            } else {
                counter.innerText = target;
            }

        };

        updateCount();
    });


    gsap.from(".grid > div", {
        duration: 0.7,
        y: -50,
        opacity: 0,
        ease: "power2.out",
        stagger: 0.3
    });

});


const investButton = document.getElementById("invest_button");
const investmentForm = document.getElementById("investment_form");

investButton.addEventListener("click", () => {
    investmentForm.scrollIntoView({ behavior: "smooth" });

    gsap.fromTo(investmentForm,
        { scale: 1 },
        { scale: 1.1, repeat: 5, yoyo: true, duration: 0.2 }
    );
});

const reviewsButton = document.getElementById("reviews_button");
const reviews = document.getElementById("reviews");

reviewsButton.addEventListener("click", () => {
    reviews.scrollIntoView({ behavior: "smooth" });
})