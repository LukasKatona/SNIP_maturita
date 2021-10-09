class Rank {
  final int minXp;
  final int maxXp;
  final String rank;

  Rank({ this.minXp, this.maxXp, this.rank });
}

List<Rank> rankList = [
  Rank(minXp: 0, maxXp: 32, rank: "Beginner I"),
  Rank(minXp: 32, maxXp: 64, rank: "Beginner II"),
  Rank(minXp: 64, maxXp: 128, rank: "Beginner III"),
  Rank(minXp: 128, maxXp: 256, rank: "Intermediate I"),
  Rank(minXp: 256, maxXp: 512, rank: "Intermediate II"),
  Rank(minXp: 512, maxXp: 1024, rank: "Intermediate III"),
  Rank(minXp: 1024, maxXp: 2048, rank: "Advanced I"),
  Rank(minXp: 2048, maxXp: 4096, rank: "Advanced II"),
  Rank(minXp: 4096, maxXp: 8192, rank: "Advanced III"),
];