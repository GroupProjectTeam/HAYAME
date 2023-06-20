# HAYAME project のリポジトリです．
プロジェクトリーダーより  
あまりシステム開発詳しいわけではないので  
エラーメッセージが出ても回答できないことが多いと思います  
（たぶん私のほうが聞くことが多いと思う）．  
サポートよろしくお願いします．

## README.md のMARKDOWNの書き方
MARKDOWNの書き方は[こちら](https://gist.github.com/mignonstyle/083c9e1651d7734f84c99b8cf49d57fa)
が参考になると思う．  
改行は半角スペース二つ  
箇条書きはハイフンの後に半角で以降文字列「-(半角)項目１」

## Githubの使い方
pull ~ push まで
git pull origin  

git add .  
git commit -m ”name”  

git push origin <branch_name>  

## 毎週の進捗
Googleスプレッドシート
[6/13](https://docs.google.com/document/d/19bJnzNbsbtFxdCTpE_rWWSw3wYxsmmXaZSQ9vzFKVvA/edit?usp=sharing)

## やること
1.6/13
やること
- システムについて考え切れていないので意見ほしい
- システム名は「はやめ」か「HAYAME」でよいか？  フォルダ名決めておきたいので
- 使うのはdjangoで考えているがdjangoでいい？
- 仮想環境の構築，揃える(condaが助かります．前の時pyenv的なの確かうまくいかなかった気がする)
- 分担決め（matsuo:前回はUIをメインにやった感じになったのでバックエンドやってみたいが一人じゃ無理）

決まったこと
- フレームワーク：Flutter
- 言語:Dart
- システム：予定を変更するたびに新しい予定表を提供してくれる（カーナビ的な）
- 分担：JIANG(UI),Gao(アルゴリズム),谷(情報管理),リーダー(情報管理)

2.6/20やること
決まったこと：
データの構造

task_DB:
task_id//タスクid
title//課題の題名
priority//優先度
? if_fixed//タスクが固定か?
deadline//課題の期限
duration//課題にかかる(目標)時間
if_done//終わったかどうか
real_duration//実際にかかった時間

appointment_DB:
? appointment_id//予約id
title//課題の題名
begin_time//課題始める時間(日時)
end_time//課題終わる時間(日時)

free:  //free はデータ管理で必要
free_id//自由タスクのid
begin_free_time//自由時間開始(日時)
end_free_time//自由時間終了(日時)

schedule_DB:
task_id//タスクid
subtask_id//task_idを分割した時のタスクリスト task_id - A, subtask_id - A1, A2,...
begin_time//始まり
end_time//終わり

やること
各自の作業
