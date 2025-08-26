import './globals.css'
import { ReactNode } from 'react'
import { getServerSession } from 'next-auth'
import Link from 'next/link'

export default async function RootLayout({ children }: { children: ReactNode }) {
  const session = await getServerSession()
  return (
    <html lang="en">
      <body className="bg-slate-50 text-slate-900">
        <div className="min-h-screen grid grid-cols-[240px_1fr]">
          <aside className="hidden md:block border-r bg-white">
            <div className="p-4 font-semibold">Dhansatu Admin</div>
            <nav className="space-y-1 px-2">
              <Link href="/" className="block px-3 py-2 rounded hover:bg-slate-100">Dashboard</Link>
              <Link href="/signals" className="block px-3 py-2 rounded hover:bg-slate-100">Stock Signals</Link>
              <Link href="/users" className="block px-3 py-2 rounded hover:bg-slate-100">Users</Link>
              <Link href="/profile" className="block px-3 py-2 rounded hover:bg-slate-100">Profile</Link>
            </nav>
          </aside>
          <main>
            <header className="h-14 border-b bg-white flex items-center px-4 justify-between">
              <div/>
              <div className="text-sm text-slate-600">{session?.user?.email}</div>
            </header>
            {children}
          </main>
        </div>
      </body>
    </html>
  )
}

