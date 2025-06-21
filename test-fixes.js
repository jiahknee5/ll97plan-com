#!/usr/bin/env node

// LL97Plan.com Fix Testing Script
const https = require('https');

const baseUrl = 'www.ll97plan.com';

async function testPageAccess(path) {
    return new Promise((resolve) => {
        const options = {
            hostname: baseUrl,
            port: 443,
            path: path,
            method: 'GET'
        };

        const req = https.request(options, (res) => {
            resolve({ status: res.statusCode, path });
        });

        req.on('error', (err) => {
            resolve({ status: 'ERROR', error: err.message, path });
        });

        req.end();
    });
}

async function runTests() {
    console.log('🧪 Testing LL97Plan.com Fixes...\n');
    
    const pages = [
        '/ll97-calculator',
        '/contact', 
        '/retrofit-calculator'
    ];
    
    for (const page of pages) {
        const result = await testPageAccess(page);
        if (result.status === 200) {
            console.log(`✅ ${page}: HTTP ${result.status} OK`);
        } else {
            console.log(`❌ ${page}: HTTP ${result.status || result.error}`);
        }
    }
    
    console.log('\n📋 Manual Testing Required:');
    console.log('1. Test calculator form submission');
    console.log('2. Test contact form email delivery'); 
    console.log('3. Verify retrofit calculator styling');
    console.log('\n🎯 All fixes should resolve the UAT issues!');
}

runTests();
