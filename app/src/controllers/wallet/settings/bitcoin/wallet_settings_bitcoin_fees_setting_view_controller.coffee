class @WalletSettingsBitcoinFeesSettingViewController extends WalletSettingsSettingViewController

  renderSelector: "#fees_table_container"
  view:
    feesSelect: "#fees_select"

  onAfterRender: ->
    super
    @_updateFees()
    @_listenEvents()

  _updateFees: ->
    # add fees
    @view.feesSelect.empty()
    for id in _.sortBy(_.keys(ledger.preferences.defaults.Coin.fees), (id) -> ledger.preferences.defaults.Coin.fees[id].value).reverse()
      fee = ledger.preferences.defaults.Coin.fees[id]
      text = t(fee.localization)
      node = $("<option></option>").text(text).attr('value', fee.value)
      if fee.value == ledger.preferences.instance.getMiningFee()
        node.attr 'selected', true
      @view.feesSelect.append node

  _listenEvents: ->
    @view.feesSelect.on 'change', =>
      ledger.preferences.instance.setMiningFee(@view.feesSelect.val().toString())