class Mortgage {
  num _amount;
  num _rate;
  num _term;
  num _fistPayment;
  num _payment;
  num _overPayment;

  Mortgage(this._amount, this._rate, this._term, this._fistPayment, this._payment , this._overPayment);

  num get payment => _payment;

  set payment(num value) {
    _payment = value;
  }

  num get term => _term;

  set term(num value) {
    _term = value;
  }

  num get rate => _rate;

  set rate(num value) {
    _rate = value;
  }

  num get amount => _amount;

  set amount(num value) {
    _amount = value;
  }

  num get fistPayment => _fistPayment;

  set fistPayment(num value) {
    _fistPayment = value;
  }

  num get overPayment => _overPayment;

  set overPayment(num value) {
    _overPayment = value;
  }

  void setMortgageInf(num amount, num rate, num term, num firstPayment, payment) {
    this._amount = amount;
    this._rate = rate;
    this._term = term;
    this._fistPayment = firstPayment;
    this._payment = payment;
  }
}