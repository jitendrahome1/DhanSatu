"use client"
import { useEffect, useState } from 'react'
import Link from 'next/link'

type StockSignal = {
  id: number
  stockName: string
  currentPrice: number
  profitPercent: number
  stopLoss: number
  target: number
  status: string
  entryDate: string
}

export default function SignalsPage() {
  const [signals, setSignals] = useState<StockSignal[]>([])
  const [loading, setLoading] = useState(true)

  async function refresh() {
    try {
      const r = await fetch('/api/signals')
      setSignals(await r.json())
    } finally { setLoading(false) }
  }
  useEffect(() => { refresh() }, [])

  return (
    <main className="min-h-screen p-6">
      <div className="max-w-6xl mx-auto">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-semibold">Stock Signals</h1>
          <Link className="px-3 py-2 rounded bg-slate-900 text-white" href="/signals/new">New Signal</Link>
        </div>
        {loading ? <p className="mt-6">Loading…</p> : (
          <div className="mt-6 overflow-x-auto bg-white border rounded">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-slate-50 text-left">
                  <th className="p-2">ID</th>
                  <th className="p-2">Stock</th>
                  <th className="p-2">Price</th>
                  <th className="p-2">Profit %</th>
                  <th className="p-2">SL</th>
                  <th className="p-2">Target</th>
                  <th className="p-2">Status</th>
                  <th className="p-2">Entry</th>
                </tr>
              </thead>
              <tbody>
                {signals.map(s => (
                  <tr key={s.id} className="border-t">
                    <td className="p-2">{s.id}</td>
                    <td className="p-2">{s.stockName}</td>
                    <td className="p-2">{s.currentPrice}</td>
                    <td className="p-2">{s.profitPercent}</td>
                    <td className="p-2">{s.stopLoss}</td>
                    <td className="p-2">{s.target}</td>
                    <td className="p-2">{s.status}</td>
                    <td className="p-2">{new Date(s.entryDate).toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </main>
  )
}

