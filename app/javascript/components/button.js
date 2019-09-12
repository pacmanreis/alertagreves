const clickSubmit = () => {
  const searchButton = document.getElementById("basic-text1");
  const hiddenButton = document.querySelector(".hidden-submit-button");
  if (searchButton) {
    searchButton.addEventListener("click", () => {
      hiddenButton.click();
    })
  }
}

export { clickSubmit }
