
// Contact Form Fix - Email Submission Handler
// File: contact page JavaScript

function handleContactSubmission(event) {
    event.preventDefault();
    
    const formData = new FormData(event.target);
    const contactData = {
        name: formData.get('name'),
        email: formData.get('email'),
        company: formData.get('company') || '',
        phone: formData.get('phone') || '',
        message: formData.get('message')
    };
    
    // Validate required fields
    if (!contactData.name || !contactData.email || !contactData.message) {
        showMessage('Please fill in all required fields', 'error');
        return;
    }
    
    // Validate email format
    if (!isValidEmail(contactData.email)) {
        showMessage('Please enter a valid email address', 'error');
        return;
    }
    
    // Show loading state
    const submitBtn = event.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Sending...';
    submitBtn.disabled = true;
    
    // Submit to backend
    submitContactForm(contactData)
        .then(response => {
            if (response.success) {
                showMessage('Thank you! Your message has been sent successfully. We will respond within 24 hours.', 'success');
                event.target.reset();
            } else {
                throw new Error(response.message || 'Submission failed');
            }
        })
        .catch(error => {
            console.error('Contact form error:', error);
            showMessage('Sorry, there was an error sending your message. Please email us directly at info@ll97plan.com', 'error');
        })
        .finally(() => {
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
        });
}

async function submitContactForm(contactData) {
    // This needs to be implemented with actual backend endpoint
    // For now, using a placeholder that would integrate with email service
    
    const response = await fetch('/api/contact-submit', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            ...contactData,
            to: 'info@ll97plan.com',
            subject: `LL97Plan Contact: ${contactData.name} - ${contactData.company}`,
            timestamp: new Date().toISOString()
        })
    });
    
    return await response.json();
}

function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function showMessage(message, type) {
    // Remove existing messages
    const existingMsg = document.querySelector('.form-message');
    if (existingMsg) existingMsg.remove();
    
    // Create new message
    const msgDiv = document.createElement('div');
    msgDiv.className = `form-message ${type}`;
    msgDiv.textContent = message;
    
    // Insert after form
    const form = document.querySelector('form');
    form.parentNode.insertBefore(msgDiv, form.nextSibling);
    
    // Auto-remove success messages after 5 seconds
    if (type === 'success') {
        setTimeout(() => msgDiv.remove(), 5000);
    }
}

// Attach event listener
document.addEventListener('DOMContentLoaded', function() {
    const contactForm = document.querySelector('form');
    if (contactForm) {
        contactForm.addEventListener('submit', handleContactSubmission);
    }
});
