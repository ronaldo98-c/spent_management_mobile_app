
class Spent {
  final int amount;
  final String raison;
  final String desciption;
  final String createdAt;

  Spent({required this.amount,  required this.raison, required this.desciption, required this.createdAt});

  //List of Plants data
  static List<Spent> spentList = [
    Spent(
        amount: 20000,
        raison: 'Achat du pain',
        desciption: 'Pour la maison',
        createdAt: '2021-05-12 13h50'),
    Spent(
        amount: 2000000,
        raison: 'Achat de la voiture',
        desciption: 'Pour mes deplacements',
        createdAt: '2021-06-12 13h50'),
    Spent(
        amount: 100,
        raison: 'Achat bic',
        desciption: 'Pour ecrire',
        createdAt: '2021-12-12 13h50'),
    Spent(
        amount: 650,
        raison: 'Achat de la nourriture',
        desciption: 'Pour manger au travail',
        createdAt: '2021-07-12 11h50'),

    Spent(
        amount: 450,
        raison: 'Achat lait',
        desciption: 'Pour boire chaque soir',
        createdAt: '2023-05-13 08h30'),

    Spent(
        amount: 450000,
        raison: 'Achat d\'un nouveau laptop',
        desciption: 'Pour travailler avec',
        createdAt: '2019-05-12 13h50'),

    Spent(
        amount: 150,
        raison: 'Achat du pain',
        desciption: 'Pour la maison',
        createdAt: '2021-05-12 13h50')
  ];
}