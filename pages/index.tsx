import type { NextPage } from 'next'
import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
      <Head>
        <title>Seitaro</title>
        <meta name="description" content="Seitaro's portfolio site" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Seitaro
        </h1>

        <p className={styles.description}>
          A software developer based in Japan.
        </p>

        <div className={styles.grid}>
          <a href="https://github.com/seita1996" className={styles.card}>
            <h2>GitHub</h2>
          </a>

          <a href="https://twitter.com/seita_1996" className={styles.card}>
            <h2>Twitter</h2>
          </a>

          <a
            href="https://note.com/seita1996"
            className={styles.card}
          >
            <h2>Note</h2>
          </a>

          <a
            href="https://zenn.dev/seita1996"
            className={styles.card}
          >
            <h2>Zenn</h2>
          </a>
        </div>

        <div>
          <span className={styles.logo}>
            <img src="/icon.svg" alt="Seitaro Logo" width={48} height={48} />
          </span>
        </div>
      </main>

      {/* <footer className={styles.footer}>
        <span className={styles.logo}>
          <img src="/icon.svg" alt="Seitaro Logo" width={48} height={48} />
        </span>
      </footer> */}
    </div>
  )
}

export default Home
