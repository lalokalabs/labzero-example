import Swal from 'sweetalert2';

document.addEventListener('DOMContentLoaded', () => {
  const button = document.createElement('button');
  button.innerText = 'Show SweetAlert';
  button.className = 'px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600';
  document.body.appendChild(button);

  button.addEventListener('click', () => {
    Swal.fire({
      title: 'Hello!',
      text: 'This is a SweetAlert2 example.',
      icon: 'success',
      confirmButtonText: 'Cool'
    });
  });
});
