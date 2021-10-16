class Rank {
  final int minXp;
  final String rank;

  Rank({ this.minXp, this.rank });
}

List<Rank> rankList = [
  Rank(minXp: 0, rank: "Beginner I"),
  Rank(minXp: 32, rank: "Beginner II"),
  Rank(minXp: 64, rank: "Beginner III"),
  Rank(minXp: 128, rank: "Intermediate I"),
  Rank(minXp: 256, rank: "Intermediate II"),
  Rank(minXp: 512, rank: "Intermediate III"),
  Rank(minXp: 1024, rank: "Advanced I"),
  Rank(minXp: 2048, rank: "Advanced II"),
  Rank(minXp: 4096, rank: "Advanced III"),
];