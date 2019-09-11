const showCreateUnionForm = () => {
  const createUnion = document.querySelector("#new-union");
  const unionForm = document.querySelector("#new-union-form");
  const unionField = document.querySelector("#union-select");
  const newUnionFields = document.querySelectorAll(".union-input-field");

  if (createUnion) {
    createUnion.addEventListener('click', (event) => {
      unionForm.classList.toggle('d-none');
      unionField.classList.toggle('d-none');
      newUnionFields.forEach ((field) => {
        field.value = "";
      })
      if (createUnion.innerText === "Create a Union below or choose one here") {
        createUnion.innerText = "Select one below or create one here";
      } else {
        createUnion.innerText = "Create a Union below or choose one here";
      }
      event.preventDefault();
    });
  }
}

export default showCreateUnionForm;
