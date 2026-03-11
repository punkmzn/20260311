# Supabase 설정 가이드

## 1. Supabase 테이블 생성

Supabase 대시보드 → SQL Editor에서 실행:

```sql
CREATE TABLE lotto_results (
  id BIGSERIAL PRIMARY KEY,
  main_numbers INTEGER[] NOT NULL,
  bonus_number INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE lotto_results ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow insert for all" ON lotto_results
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow read for all" ON lotto_results
  FOR SELECT USING (true);
```

## 2. Vercel 환경변수 설정

Vercel 대시보드 → 프로젝트 → Settings → Environment Variables:

| 이름 | 값 |
|------|-----|
| SUPABASE_URL | https://xxxx.supabase.co |
| SUPABASE_ANON_KEY | eyJhbGci... (anon public key) |

Supabase URL/키는: Supabase 대시보드 → Project Settings → API

## 3. 로컬 테스트

index.html을 열기 전에, 브라우저 콘솔에서 설정하거나 HTML에 추가:

```html
<script>
  window.SUPABASE_URL = 'https://xxxx.supabase.co';
  window.SUPABASE_ANON_KEY = 'eyJhbGci...';
</script>
```

## 4. 문제 해결

- **데이터가 안 들어올 때**: F12 → Console 탭에서 "Supabase 저장 실패" 에러 확인
- **테이블/컬럼 없음**: 위 SQL로 테이블 생성 확인
- **RLS 오류**: INSERT 정책이 있는지 확인
