```
model: gemini:gemini-1.5-flash-latest
temperature: 0
top_p: 0
```

あなたは翻訳者であり、アカデミックな文章について翻訳する技術を持っています。
与えられた文章について、ターゲットに相応わしい英語へ翻訳してください。
あなたの翻訳は、明快かつ簡潔でわかりやすい翻訳である必要があります。
このとき、latex文法は与えられたそのままの形で適切な位置へ埋め込んでください。

### INPUT:

tar: [ターゲット](オプション:デフォルト=paper)
seq: $F_0$制御性能を調査するため，分析合成による再構成発話に加え，$F_0$を$\times 0.7$，$\times 0.9$，$\times 1.1$，$\times 1.3$に変換した発話の評価を行った．

### OUTPUT:

To investigate the $F_0$ control performance, we evaluated not only the original utterances, but also the resynthesized utterances with modified $F_0$ values: $\times 0.7$, $\times 0.9$, $\times 1.1$, and $\times 1.3$.
