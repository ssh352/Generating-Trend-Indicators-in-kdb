\l C:\Users\James\analystInfo\analystInfo
10#tradeInfo
tables[]
get `:sym

macdBTC
19#rsiBTC
10#tradeInfo
.qp.go[500;500] .qp.line[rsiBTC; `date;`rsi; ::]
macdChart:{
    fillscale : .gg.scale.colour.cat 01b!(.gg.colour.Red; .gg.colour.Green);
    
    
    }
.qp.stack (
    .qp.go[500;500] .qp.line[macdBTC; `date;`macd; ::];
    .qp.go[500;500] .qp.line[macdBTC; `date;`signal; ::]
    )

.qp.stack (
    .qp.point[macdBTC; `date; `macd; ::];
    .qp.line[macdBTC; `date; `signal; ::]
    )

tab:select date,sym,exch,open,close,highPr,lowPr from tradeInfo where sym=`BTC_USD,exch=`KRAKEN
update gain: close > open from `tab
10#tab
candlestick : {
    fillscale : .gg.scale.colour.cat 01b!(.gg.colour.Red; .gg.colour.Green);

    .qp.theme[enlist[`legend_use]!enlist 0b]
    .qp.stack (
        // open/close
       .qp.interval[x; `date; `open; `close]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            , .qp.s.geom[`gap`colour!(0; .gg.colour.White)];
        // low/high
        .qp.segment[x; `date; `highPr; `date; `lowPr]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            , .qp.s.geom[enlist [`size]!enlist 1])
    };

.qp.go[700;300]
    .qp.theme[.gg.theme.clean]
    .qp.title["Candlestick chart"]
    candlestick tab


t : ([]x:5 * til 45; y: til 45; z: 45?`a`b`c)
.qp.vertical (
    .qp.point[t; `x; `y]
        .qp.s.link[`myid];
    .qp.line[t; `z; `x]
        .qp.s.link[`myid])

.gg.scale.colour.cat

//volume plot bitcoin
btcTrade:select from tradeInfo where sym=`BTC_USD,exch in `HITBTC`KRAKEN,date>2019.05.09
.qp.go[500;500]
    .qp.title["BTC Volume Graph"]
    .qp.line[btcTrade; `date; `volume]
        .qp.s.aes[`group; `exch]
        , .qp.s.aes[`fill; `exch]
//ETH
ethTrade:select from tradeInfo where sym=`ETH_USD,exch in `HITBTC`KRAKEN,date>2019.05.09
.qp.go[500;500]
    .qp.title["ETH Volume Graph"]
    .qp.line[ethTrade; `date; `volume]
        .qp.s.aes[`group; `exch]
        , .qp.s.aes[`fill; `exch]


//close graph- fairly poor
.qp.go[500;500]
    .qp.title["BTC Close"]
    .qp.line[btcTrade; `date; `close]
        .qp.s.aes[`group; `exch]
        , .qp.s.aes[`fill; `exch]
.qp.go[500;500]
    .qp.title["ETH Close "]
    .qp.line[ethTrade; `date; `close]
        .qp.s.aes[`group; `exch]
        , .qp.s.aes[`fill; `exch]

//do one of the candle stick stuff for eth and btc. then do avg and moving avg.
candlestick : {
    fillscale : .gg.scale.colour.cat 01b!(.gg.colour.Red; .gg.colour.Green);
    
    .qp.theme[enlist[`legend_use]!enlist 0b]
    .qp.stack (
        // open/close
       .qp.interval[x; `date; `open; `close]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            ,.qp.s.labels[`x`y!("PRICE";"DATE")]
            , .qp.s.geom[`gap`colour!(0; .gg.colour.White)];
        // low/high
        .qp.segment[x; `date; `highPr; `date; `lowPr]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            ,.qp.s.labels[`x`y!("PRICE";"DATE")]
            , .qp.s.geom[enlist [`size]!enlist 1])
    };
t1:update gain: close > open from select from btcTrade where sym=`KRAKEN
10#t1
10#btcTrade
//BTC
.qp.go[700;300]
    .qp.theme[.gg.theme.clean]
    .qp.title["Candlestick chart BTC"]
    //.qp.s.labels[`x`y!("X TITLE";"Y TITLE")]
    candlestick[update gain: close > open from select from btcTrade where exch=`KRAKEN]

//ETH
.qp.go[700;300]
    .qp.theme[.gg.theme.clean]
    .qp.title["Candlestick chart ETH"]
    //.qp.s.labels[`x`y!("X TITLE";"Y TITLE")]
    candlestick[update gain: close > open from select from ethTrade where exch=`KRAKEN]

tables[]
10#rsiBTC
.qp.go[500;500]
    .qp.title["TITLE HERE"]
    .qp.theme[.gg.theme.clean]
    .qp.stack(
        .qp.line[select from rsiETH where not null rsi; `date; `rsi]
            .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
            , .qp.s.labels[`x`y!("rsi %";"DATE")];
        .qp.hline[70]
            .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
            , .qp.s.labels[`x`y!("rsi %";"DATE")];
        .qp.hline[30]
            .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
            , .qp.s.labels[`x`y!("rsi %";"DATE")]
    )

##############################################################
##############################################################
####GOOD###########################################

candlestick : {
    fillscale : .gg.scale.colour.cat 01b!(.gg.colour.Red; .gg.colour.Green);
    
    .qp.theme[enlist[`legend_use]!enlist 0b]
    .qp.stack (
        // open/close
       .qp.interval[x; `date; `open; `close]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            ,.qp.s.labels[`x`y!("Date";"Price")]
            , .qp.s.geom[`gap`colour!(0; .gg.colour.White)];
        // low/high
        .qp.segment[x; `date; `high; `date; `low]
            .qp.s.aes[`fill; `gain]
            , .qp.s.scale[`fill; fillscale]
            ,.qp.s.labels[`x`y!("Date";"Price")]
            , .qp.s.geom[enlist [`size]!enlist 1])
    };

.qp.go[700;300]
    .qp.theme[.gg.theme.clean]
    .qp.title["Candlestick chart BTC"]
    //.qp.s.labels[`x`y!("X TITLE";"Y TITLE")]
    candlestick[update gain: close > open from select from wpData where sym=`BTC_USD,exch=`KRAKEN]

sma:{[x]
    .qp.go[700;300]
        .qp.title["SMA BTC Kraken"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `sma10]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; `sma10`sma20`close!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `sma20]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `close]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    , .qp.s.labels[`x`y!("Date";"Price")])}

-4#wpData
3#update sma10:mavg[10;close],sma20:mavg[15;close] from select from wpData where sym=`BTC_USD,exch=`KRAKEN
sma[update sma10:mavg[10;close],sma20:mavg[20;close] from select from wpData where sym=`BTC_USD,exch=`KRAKEN

wpData:get `:analystInfo/newCloseTab

sym:get `:analystInfo/analystInfo/sym


rsi:{[x]
    .qp.go[750;300]
        .qp.title["RSI for ETH on HITBTC, n=14"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `rsi]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; `rsiLine`lower`upper!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")];
                .qp.hline[70]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")];
                .qp.hline[30]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")])}

rsi[update rsi:rsiMain[close;14] from select from wpData where exch=`HITBTC,sym=`ETH_USD]

rsi:{[x]
    .qp.go[700;300]
        .qp.title["RSI for ETH on HITBTC with n=14"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `rsi]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; `rsiLine`lower`upper!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")];
                .qp.hline[70]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")];
                .qp.hline[30]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.labels[`x`y!("Date";"RSI %")])}

rsi[update rsi:rsiMain[close;14] from select from wpData where exch=`HITBTC,sym=`ETH_USD]


sma:{[x]
    .qp.go[700;300]
        .qp.title["SMA BTC Kraken"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `sma10]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; `sma10`sma20`close!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `sma20]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `close]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.scale [`y; .gg.scale.limits[6000 0N] .gg.scale.linear]
                    ,.qp.s.labels[`x`y!("Date";"Price")])}


macdGG:{[x]
    .qp.go[700;500]
        .qp.title["MACD ETH HITBTC"]
        .qp.theme[.gg.theme.clean]
        .qp.vertical (
            .qp.stack(
                    .qp.line[x; `date; `close]
                        .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                        ,.qp.s.scale [`y; .gg.scale.limits[100 400] .gg.scale.linear]
                        ,.qp.s.legend[""; `close`ema12`ema26!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                        , .qp.s.labels[`x`y!("Date";"Price")];
                    .qp.line[x; `date; `ema12]
                        .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                        /,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                        , .qp.s.labels[`x`y!("Date";"Price")];
                    .qp.line[x; `date; `ema26]
                        .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                        /,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                        ,.qp.s.labels[`x`y!("Date";"Price")]);
            .qp.stack(
                    .qp.line[x; `date; `macd]
                        .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                        ,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                        ,.qp.s.legend[""; `macd`signal!(.gg.colour.Blue;.gg.colour.Red)]
                        , .qp.s.labels[`x`y!("Date";"MACD")];
                    .qp.line[x; `date; `signal]
                        .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                        /,.qp.s.scale [`y; .gg.scale.limits[0 0N] .gg.scale.linear]
                        , .qp.s.labels[`x`y!("Date";"MACD")])
        )} 
    


//macdGG[macd[wpData;`ETH_USD;`HITBTC]]



mfi:{[x]
    .qp.go[700;400]
        .qp.title["MFI for ETH on HITBTC with n=14"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `mfi]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[10 90] .gg.scale.linear]
                    ,.qp.s.legend[""; `mfiLine`lower`upper!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green)]
                    ,.qp.s.labels[`x`y!("Date";"MFI %")];                    
                .qp.hline[80]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.labels[`x`y!("Date";"MFI %")];
                .qp.hline[20]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.labels[`x`y!("Date";"MFI %")])}

//mfi[update mfi:mfiMain[high;low;close;14;vol] from select from wpData where exch=`HITBTC,sym=`ETH_USD]

mfiRsi:{[x]
    .qp.go[700;400]
        .qp.title["MFI versus RSI for ETH on HITBTC with n=14"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `mfi]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[30 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; `mfi`rsi!(.gg.colour.Blue;.gg.colour.Red)]
                    ,.qp.s.labels[`x`y!("Date";"MFI/RSI %")];
                .qp.line[x; `date; `rsi]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.labels[`x`y!("Date";"MFI/RSI %")])}
//mfiRsi[update mfi:mfiMain[high;low;close;14;vol],rsi:rsiMain[close;14] from select from wpData where exch=`HITBTC,sym=`ETH_USD]


bollingerBands:{[x]
    .qp.go[700;300]
        .qp.title["20 day Bollinger Bands BTC Kraken"]
        .qp.theme[.gg.theme.clean]
            .qp.stack(
                .qp.line[x; `date; `sma]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[5000 13000] .gg.scale.linear]
                    ,.qp.s.legend[""; `sma`down`up`TypPrie!(.gg.colour.Blue;.gg.colour.Red;.gg.colour.Green;.gg.colour.Purple)]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `down]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    , .qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `up]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.labels[`x`y!("Date";"Price")];
                .qp.line[x; `date; `TP]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Purple]
                    , .qp.s.labels[`x`y!("Date";"Price")])}

bollingerBands[bollB[wpData;20;`KRAKEN;`BTC_USD]]

cciPlot:{[x]
    .qp.go[700;400]
        .qp.title["CCI + Close Price for BTC_USD on Kraken"]
        .qp.theme[.gg.theme.clean]
        .qp.vertical (
            .qp.line[x; `date; `cci]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `cci)!(enlist .gg.colour.Blue)]
                    ,.qp.s.labels[`x`y!("Date";" CCI")];
            .qp.line[select from x where date>2019.05.21; `date; `close]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `price)!(enlist .gg.colour.Red)]
                    ,.qp.s.labels[`x`y!("Date";" Price")])}

cciPlot[update cci:CCI[high;low;close;14] from select from wpData where sym=`BTC_USD,exch=`KRAKEN]


forceIndexPlot:{[x]
    .qp.go[700;600]
        .qp.title["ForceIndex + Close Price for BTC_USD on Kraken"]
        .qp.theme[.gg.theme.clean]
        .qp.vertical (
            .qp.line[x; `date; `forceInd]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `forceInd)!(enlist .gg.colour.Blue)]
                    ,.qp.s.labels[`x`y!("Date";" ForceInd")];
            .qp.line[select from x where date>2019.05.21; `date; `close]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `price)!(enlist .gg.colour.Red)]
                    ,.qp.s.labels[`x`y!("Date";" Price")])}

forceIndexPlot[update forceInd:forceIndex[close;vol;13] from select from wpData where sym=`BTC_USD,exch=`KRAKEN]
emvPlot:{[x]
    .qp.go[700;600]
        .qp.title["EMV + Close Price + Volume for ETH_USD on Kraken"]
        .qp.theme[.gg.theme.clean]
        .qp.vertical (
            .qp.line[x; `date; `EMV]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `EMV)!(enlist .gg.colour.Blue)]
                    ,.qp.s.labels[`x`y!("Date";" EVM")];
            .qp.line[select from x where date>2019.05.23; `date; `close]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `price)!(enlist .gg.colour.Red)]
                    ,.qp.s.labels[`x`y!("Date";" Price")];
            .qp.bar[select from x where date>2019.05.23; `date; `vol]
                    .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                    ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                    ,.qp.s.legend[""; (enlist `vol)!(enlist .gg.colour.Green)]
                    ,.qp.s.labels[`x`y!("Date";" Volume")])}

emvPlot[select date,vol,close,EMV:emv[high;low;vol;10000;14] from wpData where sym=`ETH_USD,exch=`KRAKEN]



rocGraph:{.qp.go[500;500]
    .qp.title["ROC BTC on Kraken"]
    .qp.theme[.gg.theme.clean]
    .qp.vertical (
        .qp.line[x; `date; `close]
                .qp.s.geom[enlist[`fill]!enlist .gg.colour.Green]
                ,.qp.s.scale [`y; .gg.scale.limits[0N 0N] .gg.scale.linear]
                , .qp.s.labels[`x`y!("Date";"Close Price %")];
        .qp.stack(
            .qp.line[x; `date; `ROC]
                .qp.s.geom[enlist[`fill]!enlist .gg.colour.Blue]
                ,.qp.s.scale [`y; .gg.scale.limits[-30 30] .gg.scale.linear]
                , .qp.s.labels[`x`y!("Date";"ROC %")];
            .qp.hline[0]
                .qp.s.geom[enlist[`fill]!enlist .gg.colour.Red]
                , .qp.s.labels[`x`y!("Date";"ROC %")]
    ))}

rocGraph[select date,close,ROC:roc[close;9] from wpData where sym=`BTC_USD,exch=`KRAKEN]
