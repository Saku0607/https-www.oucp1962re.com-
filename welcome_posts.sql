-- 高校生・新入生向けページの企画投稿テーブル
-- 現在のサイトは画面内の共通パスワード方式のため、Supabase側では未認証ロールにも投稿操作を許可しています。
-- このため、パスワード画面を経由せずAPIから追加・編集・削除することも可能です。
create table if not exists public.welcome_posts (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    event_date date,
    location text,
    body text not null,
    details_url text,
    created_at timestamptz not null default now()
);

alter table public.welcome_posts enable row level security;

grant select, insert, update, delete
on public.welcome_posts
to anon, authenticated;

drop policy if exists "welcome_posts_public_read" on public.welcome_posts;
create policy "welcome_posts_public_read"
on public.welcome_posts
for select
to anon, authenticated
using (true);

drop policy if exists "welcome_posts_public_insert" on public.welcome_posts;
create policy "welcome_posts_public_insert"
on public.welcome_posts
for insert
to anon, authenticated
with check (true);

drop policy if exists "welcome_posts_public_update" on public.welcome_posts;
create policy "welcome_posts_public_update"
on public.welcome_posts
for update
to anon, authenticated
using (true)
with check (true);

drop policy if exists "welcome_posts_public_delete" on public.welcome_posts;
create policy "welcome_posts_public_delete"
on public.welcome_posts
for delete
to anon, authenticated
using (true);
