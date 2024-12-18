final RegExp emailValidation =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
final RegExp passwordValidation =
    RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
final RegExp nameValidation = RegExp(r'^[a-zA-Z][a-zA-Z\s]{1,49}$');

const String imagePlaceholder =
    'https://imgs.search.brave.com/VuuvfIqSsNvlt7Txu1-wDyIykUJp_Tgy_zDKzpOPrsE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9pLnNz/dGF0aWMubmV0L1Nj/S04xLmpwZw';
