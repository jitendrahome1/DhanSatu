import Link from 'next/link'

export default function Home() {
  return (
    <main className="min-h-screen p-6">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-2xl font-semibold">Dhansatu Admin</h1>
        <div className="mt-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          <Link className="p-4 rounded-lg border bg-white hover:shadow" href="/signals">Stock Signals</Link>
          <Link className="p-4 rounded-lg border bg-white hover:shadow" href="/users">Users</Link>
          <Link className="p-4 rounded-lg border bg-white hover:shadow" href="/profile">Profile</Link>
        </div>
      </div>
    </main>
  )
}

