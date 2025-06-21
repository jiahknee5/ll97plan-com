
// LL97 Calculator Fix - Form Submission Handler
// File: ll97-calculator page JavaScript

function handleCalculatorSubmission(event) {
    event.preventDefault();
    
    // Get form data
    const formData = new FormData(event.target);
    const buildingData = {
        buildingType: formData.get('building-type'),
        squareFootage: parseInt(formData.get('square-footage')),
        yearBuilt: parseInt(formData.get('year-built')),
        currentUsage: parseFloat(formData.get('current-usage'))
    };
    
    // Validate required fields
    if (!buildingData.buildingType || !buildingData.squareFootage || !buildingData.yearBuilt) {
        alert('Please fill in all required fields');
        return;
    }
    
    // Show loading state
    const submitBtn = event.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Calculating...';
    submitBtn.disabled = true;
    
    // Calculate LL97 compliance
    const results = calculateLL97Compliance(buildingData);
    
    // Display results
    displayCalculationResults(results);
    
    // Reset button
    submitBtn.textContent = originalText;
    submitBtn.disabled = false;
}

function calculateLL97Compliance(buildingData) {
    // LL97 calculation logic based on building type and usage
    const limits = {
        'office': 38.4,
        'residential': 54.79,
        'hotel': 55.45,
        'retail': 25.83,
        'warehouse': 25.83
    };
    
    const limit = limits[buildingData.buildingType.toLowerCase()] || 50;
    const isCompliant = buildingData.currentUsage <= limit;
    const penalty = isCompliant ? 0 : calculatePenalty(buildingData, limit);
    
    return {
        isCompliant,
        currentUsage: buildingData.currentUsage,
        limit: limit,
        penalty: penalty,
        recommendations: generateRecommendations(buildingData, isCompliant)
    };
}

function calculatePenalty(buildingData, limit) {
    const excess = buildingData.currentUsage - limit;
    const penaltyRate = 268; // per ton CO2e
    const emissionsFactor = 0.000431; // metric tons CO2e per kBtu
    
    return Math.round(excess * buildingData.squareFootage * emissionsFactor * penaltyRate);
}

function displayCalculationResults(results) {
    const resultsDiv = document.getElementById('calculation-results') || createResultsDiv();
    
    resultsDiv.innerHTML = `
        <div class="results-container">
            <h3>${results.isCompliant ? '✅ Compliant' : '❌ Non-Compliant'}</h3>
            <div class="usage-info">
                <p><strong>Current Usage:</strong> ${results.currentUsage} kBtu/sq ft/year</p>
                <p><strong>LL97 Limit:</strong> ${results.limit} kBtu/sq ft/year</p>
                ${!results.isCompliant ? `<p class="penalty"><strong>Estimated Penalty:</strong> $${results.penalty.toLocaleString()}/year</p>` : ''}
            </div>
            <div class="recommendations">
                <h4>Recommendations:</h4>
                <ul>
                    ${results.recommendations.map(rec => `<li>${rec}</li>`).join('')}
                </ul>
            </div>
        </div>
    `;
    
    resultsDiv.style.display = 'block';
    resultsDiv.scrollIntoView({ behavior: 'smooth' });
}

function createResultsDiv() {
    const div = document.createElement('div');
    div.id = 'calculation-results';
    div.style.display = 'none';
    document.querySelector('.calculator-form').parentNode.appendChild(div);
    return div;
}

// Attach event listener to form
document.addEventListener('DOMContentLoaded', function() {
    const calculatorForm = document.querySelector('form');
    if (calculatorForm) {
        calculatorForm.addEventListener('submit', handleCalculatorSubmission);
    }
});
