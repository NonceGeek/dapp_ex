import { connect, lastConnectedWalletType } from '../aptos-wallet'

const MARKET_ADDR = '0x8444b675957431eea8ba816a2653bc5454427959fc0eecca55de814009b9be81'

export default Wallet = {
  mounted () {
    let wallet

    window.addEventListener('load', async () => {
      // console.log('load')
      const walletType = lastConnectedWalletType()

      if (walletType) {
        wallet = await connect(walletType)
        // const address = await wallet.account()
        // login(address)
      }
    })

    window.addEventListener('phx:connect-petra', async () => {
      console.log('connect petra')
      wallet = await connect('aptos')

      const address = await wallet.account()
      login(address)
      // this.pushEvent('wallet-info', { address: address, walletType: 'petra' })
    })

    window.addEventListener('phx:connect-martian', async () => {
      console.log('connect martian')
      wallet = await connect('martian')

      const address = await wallet.account()
      this.pushEvent('wallet-info', { address: address, walletType: 'martian' })
    })

    window.addEventListener('phx:connect-starmask', async () => {
      console.log('connect starmask')
      wallet = await connect('starmask')
      const address = await wallet.account()
      this.pushEvent('wallet-info', { address: address, walletType: 'starmask' })
    })

    window.addEventListener('phx:disconnect', async () => {
      console.log('disconnect')
      await wallet.disconnect()
      this.pushEvent('wallet-info', { address: null, walletType: null })
    })

    window.addEventListener('phx:mint', async () => {
      const payload = {
        type: 'entry_function_payload',
        function: `${MARKET_ADDR}::LEAF::mint_script`,
        type_arguments: [],
        arguments: []
      }

      console.log('payload', payload)
      
      console.log(await wallet.account())

      try {
        const result = await wallet.signAndSubmitTransaction(payload)
        console.log('result:', result)
        this.pushEvent('mint_succeed', { hash: result.hash })
      } catch (error) {
        console.log('Error List token:', error)
      } finally {
        console.log('finally')
      }
    })
  }
}

function login (address) {
  const form = document.createElement('form')
  const element0 = document.createElement('input')
  const element1 = document.createElement('input')
  // const element2 = document.createElement('input')

  const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute('content')

  form.method = 'POST'
  form.action = '/auth'

  element0.name = '_csrf_token'
  element0.value = csrfToken
  form.appendChild(element0)

  element1.name = 'wallet_address'
  element1.value = address
  form.appendChild(element1)

  // element2.name = 'signature'
  // element2.value = signature
  // form.appendChild(element2)

  document.body.appendChild(form)

  form.submit()
}
