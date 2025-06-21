
// Backend API Fix - Contact Form Handler
// File: /api/contact-submit (Node.js/Express example)

const express = require('express');
const nodemailer = require('nodemailer');
const rateLimit = require('express-rate-limit');

// Rate limiting for contact form
const contactLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 5, // limit each IP to 5 requests per windowMs
    message: 'Too many contact form submissions, please try again later.'
});

// Email transporter configuration
const transporter = nodemailer.createTransporter({
    // Configure with your email service
    service: 'gmail', // or your email provider
    auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS
    }
});

app.post('/api/contact-submit', contactLimiter, async (req, res) => {
    try {
        const { name, email, company, phone, message } = req.body;
        
        // Validate required fields
        if (!name || !email || !message) {
            return res.status(400).json({
                success: false,
                message: 'Name, email, and message are required'
            });
        }
        
        // Validate email format
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            return res.status(400).json({
                success: false,
                message: 'Invalid email format'
            });
        }
        
        // Prepare email content
        const emailContent = {
            from: process.env.FROM_EMAIL || 'noreply@ll97plan.com',
            to: 'info@ll97plan.com',
            subject: `LL97Plan Contact: ${name}${company ? ` - ${company}` : ''}`,
            html: `
                <h2>New Contact Form Submission</h2>
                <p><strong>Name:</strong> ${name}</p>
                <p><strong>Email:</strong> ${email}</p>
                ${company ? `<p><strong>Company:</strong> ${company}</p>` : ''}
                ${phone ? `<p><strong>Phone:</strong> ${phone}</p>` : ''}
                <p><strong>Message:</strong></p>
                <p>${message.replace(/\n/g, '<br>')}</p>
                <hr>
                <p><small>Submitted: ${new Date().toLocaleString()}</small></p>
            `
        };
        
        // Send email
        await transporter.sendMail(emailContent);
        
        // Log submission (optional)
        console.log(`Contact form submission from ${email}`);
        
        res.json({
            success: true,
            message: 'Message sent successfully'
        });
        
    } catch (error) {
        console.error('Contact form error:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to send message'
        });
    }
});
