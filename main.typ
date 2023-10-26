#import "template.typ": project, remark, small

#show: project.with(title: "Herglotz Trick", date: "2023年10月9–10日，2023年10月11日，2023年10月26日")

= 倒数和

众所周知，调和级数
$
sum_(n in ZZ^+) 1 / n
= 1/1 + 1/2 + 1/3 + dots.c
-> +oo.
$
若#strong[将 $n$ 平移] $1/2$，得到下面这个级数，它发散还是收敛呢？
$
sum_(n in ZZ^+) 1 / (n+1/2)
= 1/1.5 + 1/2.5 + 1/3.5 + dots.c.
$
比较每一项，可知它的部分和总超过调和级数的一半，而调和级数发散，那它也只好发散了。
$
1/(n+0.5) > 1/2 times 1/n
space ==> space
sum_(n=1)^N 1/(n+0.5) > 1/2 sum_(n=1)^N 1/n.
$
同理，任取 $x in RR$，$sum_(n in ZZ^+) 1 / (n+x)$ 都发散，当然这只有 $n+x$ 取不到零时才有意义。

回顾调和级数，因有 $1/n$，$n$ 不能取零；而 $sum 1 / (n+1/2)$ 不再有此限制，那#strong[把 $ZZ^+$ 改成 $ZZ$] 会怎么样？#small[（这是个脑筋急转弯）]

$
sum_(n in ZZ) 1 / (n+1/2)
= 1/0.5 - 1/0.5 + 1/1.5 - 1/1.5 + dots.c
= 0.
$

#remark[求和顺序][
  $sum_(n in ZZ^+)$ 是指 $lim_(N -> +oo) sum_(n=1)^N$，$sum_(n in ZZ)$ 也应理解为 $lim_(N -> +oo) sum_(n=-N)^N$。上下限取 $N$ 或 $N+1$ 都行，关键是从 $0$ 往 $plus.minus oo$ 求和，而非 $lim_(L -> -oo) sum_(n=L)^(+oo)$ 等。
]

#set heading(numbering: none)
= 他典等

- #link("https://math.stackexchange.com/questions/581162/how-does-the-herglotz-trick-work")[sequences and series - How does the Herglotz trick work? - Mathematics Stack Exchange]
- #link("https://math.stackexchange.com/questions/141470/find-the-sum-of-sum-frac1k2-a2-when-0a1/143179")[sequences and series - Find the sum of $sum 1/(k^2 - a^2)$ when $0<a<1$ - Mathematics Stack Exchange]
- #link("https://math.stackexchange.com/questions/110494/possibility-to-simplify-sum-limits-k-infty-infty-frac-left/110495")[calculus - Possibility to simplify $sum_(k = -oo)^oo (-1)^k/(a + k) = pi/sin(pi a)$ - Mathematics Stack Exchange]
