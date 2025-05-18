  <h5 class="text-center bold" style="color: #a084e8;">
    <c:choose>
      <c:when test="${not empty credit}">Modifier la demande</c:when>
      <c:otherwise>Nouvelle Demande</c:otherwise>
    </c:choose>
  </h5>

  <span class="input-group-text">
    <i class="bi bi-currency-dollar text-primary"></i>
  </span>
  <input type="number" id="montant" name="montant"
         class="form-control bold"
         placeholder="5000" value="${credit.montant}" required>

  <span class="input-group-text">
    <i class="bi bi-hourglass-split text-primary"></i>
  </span>
  <input type="number" id="duree" name="duree"
         class="form-control bold"
         placeholder="12" min="1" max="120" value="${credit.dureeMois}" required>

<style>
  .form-control, .input-group-text, .form-select {
    background: #232526;
    color: #fff !important;
    border: 1px solid #333;
    font-family: 'Poppins', Arial, sans-serif;
  }
  input.form-control, input.form-control:focus, input.form-control:active,
  input[type="number"], input[type="number"]:focus, input[type="number"]:active {
    color: #fff !important;
    background: #232526 !important;
    border: 1px solid #333 !important;
    caret-color: #4fc3f7;
  }
</style> 