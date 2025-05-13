<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>About Us - HIDASA Bikes</title>
<style>
.about-hero {
    position: relative;
    width: 100%;
    height: 380px;
    background: url('${pageContext.request.contextPath}/assets/images/ourstory.png') center center/cover no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: var(--header-height);
}
.about-hero-overlay {
    width: 100%;
    height: 100%;
    background: rgba(30, 30, 30, 0.45);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.about-subtitle {
    color: #fff;
    font-size: 1.25rem;
    text-align: center;
    max-width: 700px;
}
.about-section {
    background: #f8f8f8;
    padding: 60px 0 40px 0;
}
.about-container {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 0 20px;
}
.about-content {
    display: flex;
    flex-wrap: wrap;
    gap: 40px;
    align-items: center;
    justify-content: center;
}
.about-image img {
    width: 350px;
    border-radius: 18px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.18);
}
.about-text {
    max-width: 600px;
}
.about-text h2 {
    font-size: 2.2rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}
.about-underline {
    width: 60px;
    height: 4px;
    background: #FF0B55;
    border-radius: 2px;
    margin-bottom: 1.5rem;
}
.about-text p {
    font-size: 1.1rem;
    color: #222;
    margin-bottom: 1.1rem;
    line-height: 1.7;
}
.highlight {
    color: #FF0B55;
    font-weight: 600;
}
@media (max-width: 900px) {
    .about-content {
        flex-direction: column;
        gap: 30px;
    }
    .about-image img {
        width: 100%;
        max-width: 350px;
    }
}
</style>
</head>
<body>

<%@ include file="navigationBar.jsp" %>

<!-- Hero Section -->
<div class="about-hero">
    <div class="about-hero-overlay">
    
        <p class="about-subtitle">
            Discover the journey of HIDASA Bikes - from a small workshop to Nepal's leading motorcycle manufacturer
        </p>
    </div>
</div>

<!-- Who We Are Section -->
<section class="about-section">
    <div class="about-container">
        <div class="about-content">
            <div class="about-text">
                <h2>Who We Are</h2>
                <div class="about-underline"></div>
                <p>
                    Founded in 2005, <span class="highlight">HIDASA Bikes</span> began as a small workshop with a big dream - to revolutionize the motorcycle industry in Nepal. What started as a passion project has now evolved into the country's leading motorcycle manufacturer, serving thousands of satisfied customers across the nation.
                </p>
                <p>
                    Our journey has been marked by innovation, quality, and an unwavering commitment to excellence. We believe that every bike we produce is not just a mode of transportation, but a statement of style, performance, and reliability.
                </p>
                <p>
                    Today, HIDASA Bikes stands as a testament to what can be achieved with dedication, vision, and a relentless pursuit of perfection. Our state-of-the-art manufacturing facility, skilled workforce, and customer-centric approach have helped us build a brand that riders trust and admire.
                </p>
            </div>
            <div class="about-image">
                <img src="${pageContext.request.contextPath}/assets/images/bikehero.jpg" alt="HIDASA Motorcycle" />
            </div>
        </div>
    </div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>