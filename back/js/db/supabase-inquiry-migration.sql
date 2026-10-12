alter table public.inquiries
  add column if not exists secondary_phone text;

grant insert on table public.inquiries to anon;

drop policy if exists "Public can submit inquiries" on public.inquiries;
create policy "Public can submit inquiries"
  on public.inquiries
  for insert
  to anon
  with check (
    name is not null
    and btrim(name) <> ''
    and email is not null
    and btrim(email) <> ''
    and phone ~ '^09[0-9]{2}-[0-9]{3}-[0-9]{4}$'
  );