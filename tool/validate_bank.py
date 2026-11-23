#!/usr/bin/env python3
"""Validates the question bank JSON files (structure, answers, duplicates, distribution).

Usage: python3 tool/validate_bank.py
Exit code 1 on any structural error.
"""
import collections
import glob
import json
import os
import re
import sys

ROOT = os.path.join(os.path.dirname(__file__), '..', 'assets', 'questions')
TARGET = {'ovr': 102, 'cpa': 84, 'prd': 132, 'sto': 36, 'scl': 102, 'sec': 78, 'obs': 66}
errors, warnings = [], []
rows = []

for path in sorted(glob.glob(os.path.join(ROOT, '[0-9]*.json'))):
    with open(path, encoding='utf-8') as f:
        doc = json.load(f)
    for i, r in enumerate(doc['questions']):
        where = f"{os.path.basename(path)}#{i + 1}"
        if len(r) != 10:
            errors.append(f"{where}: expected 10 fields, got {len(r)}")
            continue
        sub, kd, comp, q, opts, ans, exp, why, scen, tip = r
        if not re.fullmatch(r'[FSTD][1-4]', kd):
            errors.append(f"{where}: bad kind/difficulty {kd}")
        if len(opts) < 3 or any(not o.strip() for o in opts):
            errors.append(f"{where}: options invalid")
        if len(set(o.strip().lower() for o in opts)) != len(opts):
            errors.append(f"{where}: duplicate options")
        idx = ans if isinstance(ans, list) else [ans]
        if any((not isinstance(a, int)) or a < 0 or a >= len(opts) for a in idx) or len(set(idx)) != len(idx):
            errors.append(f"{where}: invalid answer reference {ans}")
        if isinstance(ans, list):
            if len(ans) < 2:
                errors.append(f"{where}: multi-select needs >=2 answers")
            words = {2: 'TWO', 3: 'THREE'}
            if f"(Select {words.get(len(ans), len(ans))}.)" not in q:
                errors.append(f"{where}: multi-select must state '(Select {words.get(len(ans))}.)'")
        elif '(Select' in q:
            errors.append(f"{where}: single-answer question contains a Select instruction")
        if len(why) != len(opts):
            errors.append(f"{where}: why[] length {len(why)} != options {len(opts)}")
        for k, w in enumerate(why):
            exp_prefix = 'Correct' if k in idx else 'Wrong'
            if not w.startswith(exp_prefix):
                errors.append(f"{where}: why[{k}] should start with '{exp_prefix}'")
        for name, val in (('sub', sub), ('comp', comp), ('q', q), ('exp', exp), ('scenario', scen), ('tip', tip)):
            if not str(val).strip():
                errors.append(f"{where}: empty {name}")
        if len(exp) < 100:
            warnings.append(f"{where}: short explanation")
        rows.append(dict(cat=doc['category'], kd=kd, q=q, sub=sub, multi=isinstance(ans, list), where=where))

# duplicates (normalized question text)
norm = collections.defaultdict(list)
for r in rows:
    norm[re.sub(r'[^a-z0-9]', '', r['q'].lower())].append(r['where'])
for k, v in norm.items():
    if len(v) > 1:
        errors.append(f"duplicate question text: {v}")

cats = collections.Counter(r['cat'] for r in rows)
diff = collections.Counter(r['kd'][1] for r in rows)
kind = collections.Counter(r['kd'][0] for r in rows)
n = len(rows) or 1
print(f"Total questions: {len(rows)}")
for c, t in TARGET.items():
    flag = '' if cats[c] >= t else f'  <-- below target {t}'
    print(f"  {c}: {cats[c]}{flag}")
print('Difficulty %:', {k: round(diff[k] * 100 / n, 1) for k in '1234'}, '(target 20/35/35/10)')
print('Kind %:', {k: round(kind[k] * 100 / n, 1) for k in 'FSTD'}, '(practical S+T+D >= 60)')
print('Multi-select:', sum(r['multi'] for r in rows))
for w in warnings[:20]:
    print('WARN', w)
for e in errors:
    print('ERROR', e)
sys.exit(1 if errors else 0)
