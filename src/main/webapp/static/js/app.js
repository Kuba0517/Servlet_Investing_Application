document.addEventListener('DOMContentLoaded', () => {
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

    // gsap.from("nav", { duration: 1, y: -50, opacity: 0, ease: "power2.out" });
    // gsap.from("#hero", { duration: 1, y: 50, opacity: 0, ease: "power2.out", delay: 0.5 });
    // gsap.from("footer", { duration: 1, y: 50, opacity: 0, ease: "power2.out", delay: 1 });

    gsap.from(".grid > div", {
        duration: 1,
        y: -50,
        opacity: 0,
        ease: "power2.out",
        stagger: 0.3
    });

});