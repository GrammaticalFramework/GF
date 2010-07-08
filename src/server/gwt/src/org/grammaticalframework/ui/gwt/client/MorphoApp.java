package org.grammaticalframework.ui.gwt.client;

import java.util.*;

import com.google.gwt.core.client.*;
import com.google.gwt.user.client.ui.*;
import com.google.gwt.core.client.JavaScriptObject;

public class MorphoApp implements EntryPoint {
	private TextBox lemmaBox = new TextBox();
	private Button submitButton = new Button("Submit");
	private Grid outputGrid = new Grid(2,0);

	public void onModuleLoad() {
                HorizontalPanel inputPanel = new HorizontalPanel();
		inputPanel.add(lemmaBox);
		inputPanel.add(submitButton);

		submitButton.addClickListener(new ClickListener() {
			public void onClick(Widget sender) {
		
				String url = "http://localhost:41296/morpho/morpho.fcgi/eval";
				List<JSONRequestBuilder.Arg> args = new ArrayList<JSONRequestBuilder.Arg>();
				args.add(new JSONRequestBuilder.Arg("term", lemmaBox.getText()));
					
				JSONRequestBuilder.sendRequest(url, args, new TableCallback() {
					public void onResult (IterableJsArray<InflectionForm> table)
					{
						outputGrid.resize(table.length(),2);
						int row = 0;
						for (InflectionForm form : table.iterable()) {
							outputGrid.setText(row,0,form.getName());
							outputGrid.setText(row,1,form.getValue());
							row++;
						}
					}

					public void onError (Throwable e)
					{
						outputGrid.resize(1,1);
						outputGrid.setText(0,0,e.toString());
					}
				});
			}
		});
		

		VerticalPanel mainPanel = new VerticalPanel();
		mainPanel.add(inputPanel);
		mainPanel.add(outputGrid);
		RootPanel.get().add(mainPanel);
	}

	public interface TableCallback extends JSONCallback<IterableJsArray<InflectionForm>> { }

	public static class InflectionForm extends JavaScriptObject {
		protected InflectionForm() { }

		public final native String getName() /*-{ return this.name; }-*/;

		public final native String getValue() /*-{ return this.value; }-*/;
	}
}
