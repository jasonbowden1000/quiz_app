// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('turbolinks:load', function() {
  const newQuestionForm = document.getElementById('new_question_form');

  if (newQuestionForm) {
    const addChoiceButton = document.getElementById('add_choice');
    let count = 0;
    addChoiceButton.addEventListener('click', addChoiceToForm);

    initializeChoices();

    function addChoiceToForm() {
      ++count;
      let total = newQuestionForm.findElementsByClassName('choices');
      let newField = document.createElement('div')
      newField.classList.add('field');

      let newControl = document.createElement('div');
      newControl.classList.add('control');

      let newLabel = document.createElement('label');
      newLabel.classList.add('label', 'choice_label');
      let newLabelText = document.createTextNode("Choice " + (total + 1) + ":");
      newLabel.appendChild(newLabelText);

      let newTextInput = document.createElement('div');
      newTextInput.classList.add('columns', 'is-mobile')
      let newTextInputInner = document.createElement('div');
      newTextInputInner.classList.add('column', 'is-11-table', 'is-10-mobile');
      let textInput = document.createElement('input');
      textInput.setAttribute('type', 'text');
      textInput.classList.add('input');
      textInput.id = "choice_text_" + count;
      textInput.name = 'question[choices_attributes][' + count + '][text]';
      newTextInputInner.appendChild(textInput);
      newTextInput.appendChild(newTextInputInner);

      let closeWrapper = document.createElement('div');
      closeWrapper.classList.add('column', 'is-1-tablet', 'is-2-mobile');
      let closeWrapperInner = document.createElement('div');
      closeWrapperInner.classList.add('close');
      let closeText = document.createTextNode('X');
      closeWrapperInner.appendChild(closeText);
      closeWrapperInner.addEventListener('click', removeField);
      closeWrapper.appendChild(closeWrapperInner);
      newTextInput.appendChild(closeWrapper);


      let newRadioInputTrueLabel = document.createElement('label');
      newRadioInputTrueLabel.classList.add('radio');
      let newRadioInputTrue = document.createElement('input');
      newRadioInputTrue.setAttribute('type', 'radio');
      newRadioInputTrue.setAttribute('value', 'true');
      newRadioInputTrue.name = 'question[choices_attributes][' + count + '][truth_value]';
      newRadioInputTrue.id = "choice_true_" + count;
      newRadioInputTrueText = document.createTextNode(' True');
      newRadioInputTrueLabel.appendChild(newRadioInputTrue);
      newRadioInputTrueLabel.appendChild(newRadioInputTrueText);

      let newRadioInputFalseLabel = document.createElement('label');
      newRadioInputFalseLabel.classList.add('radio');
      let newRadioInputFalse = document.createElement('input');
      newRadioInputFalse.setAttribute('type', 'radio');
      newRadioInputFalse.setAttribute('value', 'false');
      newRadioInputFalse.name = 'question[choices_attributes][' + count + '][truth_value]';
      newRadioInputFalse.id = "choice_false_" + count;
      newRadioInputFalseText = document.createTextNode(' False');
      newRadioInputFalseLabel.appendChild(newRadioInputFalse);
      newRadioInputFalseLabel.appendChild(newRadioInputFalseText);

      newControl.appendChild(newLabel);
      newControl.appendChild(newTextInput);
      newControl.appendChild(newRadioInputTrueLabel);
      newControl.appendChild(newRadioInputFalseLabel);
      newField.appendChild(newControl);

      newQuestionForm.insertBefore(newField, addChoiceButton);
    }

    function initializeChoices() {
      const choices = Array.from(newQuestionForm.getElementsByClassName('choice'));
      choices.forEach(choice => {
        let closeField = choice.querySelector('.close');
        closeField.addEventListener('click', removeField);
      });
    }

    function removeField(e) {
      let fieldToRemove = e.srcElement.closest('.field');
      fieldToRemove.parentNode.removeChild(fieldToRemove);

      updateLabels();
    }

    function updateLabels() {
      let choiceLabels = newQuestionForm.querySelectorAll('.choice_label');
      choiceLabels.forEach((label, i) => label.textContent = `Choice ${i + 1}:`);
    }
  }
});
